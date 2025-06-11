part of '../../post.dart';

@lazySingleton
class PostRepository {
  final _storage = getIt<StorageService>();
  final _restClient = getIt<RestClient>();
  final _uploadService = getIt<UploadService>();

  Future<Result<List<PostModel>>> getPosts({
    int page = 0,
    int size = 10,
    String? sort,
  }) async {
    try {
      final queryParams = {
        'page': page,
        'size': size,
        'eagerload': true,
      };

      // Add sort parameter if provided
      if (sort != null) {
        queryParams['sort'] = sort;
      }

      final response = await _restClient.get<List<PostModel>>(
        '/posts',
        queryParameters: queryParams,
        decodeData: (data) {
          return (data as List)
              .map((e) => PostModel.fromJson(e as Map<String, dynamic>))
              .toList();
        },
      );
      return Success(response);
    } catch (e) {
      if (e is DioException) {
        return Failure(AppError.fromDioException(e));
      }
      return Failure(AppError(
        'An error occurred while fetching posts',
        stackTrace: StackTrace.current,
      ));
    }
  }

  Future<Result<List<MetaDataFile>>> getFilesInPost(
      List<String> fileUrls) async {
    try {
      final result = await Future.wait(
        fileUrls.map((url) async {
          final metadata = await _uploadService.fetchFileMetadata(
            url,
            bearerToken: _storage.userToken,
          );
          log('File metadata for $url: $metadata');
          return MetaDataFile(
            url: url,
            name: metadata['Content-Disposition'] != null
                ? getFileNameRegExp(metadata['Content-Disposition'] ?? '')
                : 'Unknown',
            type: metadata['contentType'],
            size: metadata['contentLength'] != null
                ? int.parse(metadata['contentLength'] ?? '0')
                : 0,
          );
        }),
      );
      return Success(result);
    } catch (e) {
      log('Error fetching files in post: $e');
      if (e is DioException) {
        return Failure(AppError.fromDioException(e));
      }
      return Failure(AppError(
        'An error occurred while fetching files in post',
        stackTrace: StackTrace.current,
      ));
    }
  }

  String getFileNameRegExp(String contentDisposition) {
    RegExp regExp = RegExp(r'"([^"]+)"');
    final match = regExp.firstMatch(contentDisposition);
    return match != null ? (match.group(1) ?? 'Unknown') : 'Unknown';
  }

  Future<Result<List<PostModel>>> searchPosts({
    required String query,
    int page = 0,
    int size = 10,
    String? sort,
  }) async {
    try {
      final queryParams = {
        'query': query,
        'page': page,
        'size': size,
      };

      // Add sort parameter if provided
      if (sort != null) {
        queryParams['sort'] = sort;
      }

      final response = await _restClient.get<List<PostModel>>(
        '/posts/_search',
        queryParameters: queryParams,
        decodeData: (data) {
          return (data as List)
              .map((e) => PostModel.fromJson(e as Map<String, dynamic>))
              .toList();
        },
      );
      return Success(response);
    } catch (e) {
      if (e is DioException) {
        return Failure(AppError.fromDioException(e));
      }
      return Failure(AppError(
        'An error occurred while fetching posts',
        stackTrace: StackTrace.current,
      ));
    }
  }

  Future<Result<List<PostTag>>> getPostTags() async {
    try {
      final response = await _restClient.get<List<PostTag>>(
        '/tags',
        decodeData: (data) {
          return (data as List)
              .map((e) => PostTag.fromJson(e as Map<String, dynamic>))
              .toList();
        },
      );
      return Success(response);
    } catch (e) {
      if (e is DioException) {
        return Failure(AppError.fromDioException(e));
      }
      return Failure(AppError(
        'An error occurred while fetching post tags',
        stackTrace: StackTrace.current,
      ));
    }
  }

  Future<Result<PostModel>> createPost({
    required String content,
    required List<File> files,
    required String privacy,
    List<PostTag>? tags,
  }) async {
    try {
      // Create form data map
      final Map<String, dynamic> formDataMap = {
        'content': content,
        'privacy': privacy,
      };

      // Add files if there are any
      if (files.isNotEmpty) {
        formDataMap['files'] = await Future.wait([
          for (var file in files)
            MultipartFile.fromFile(
              file.path,
              filename: file.path.split('/').last,
            ),
        ]);
      }

      // Add tags if provided (optional)
      if (tags != null && tags.isNotEmpty) {
        formDataMap['tags'] = tags.map((tag) => tag.id).toList();
      }

      final formData = FormData.fromMap(formDataMap);

      // Log form data for debugging
      for (var field in formData.fields) {
        log('FormData field: ${field.key} = ${field.value}');
      }
      for (var file in formData.files) {
        log('FormData file: ${file.key} = ${file.value.filename}');
      }

      final response = await _restClient.post<PostModel>(
        '/posts/with-files',
        data: formData,
        decodeData: (data) => PostModel.fromJson(data as Map<String, dynamic>),
      );

      return Success(response);
    } catch (e) {
      log('CreatePost error: $e');
      if (e is DioException) {
        return Failure(AppError.fromDioException(e));
      }
      return Failure(AppError(
        'An error occurred while creating the post',
        stackTrace: StackTrace.current,
      ));
    }
  }

  // Convenience method for creating posts without files
  Future<Result<PostModel>> createTextPost({
    required String content,
    required String privacy,
    List<PostTag>? tags,
  }) async {
    return createPost(
      content: content,
      files: [], // Empty file list
      privacy: privacy,
      tags: tags,
    );
  }

  Future<Result<List<PostModel>>> getMyPosts({
    int page = 0,
    int size = 10,
  }) async {
    try {
      final response = await _restClient.get<List<PostModel>>(
        '/posts/me',
        queryParameters: {
          'page': page,
          'size': size,
        },
        decodeData: (data) {
          return (data as List)
              .map((e) => PostModel.fromJson(e as Map<String, dynamic>))
              .toList();
        },
      );
      return Success(response);
    } catch (e) {
      if (e is DioException) {
        return Failure(AppError.fromDioException(e));
      }
      return Failure(AppError(
        'An error occurred while fetching my posts',
        stackTrace: StackTrace.current,
      ));
    }
  }
}
