import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';

class UploadService {
  Future<Map<String, dynamic>> fetchFileMetadata(String url, {String? bearerToken}) async {
    final Dio dio = Dio();
    if (bearerToken != null) {
      dio.options.headers['Authorization'] = 'Bearer $bearerToken';
    }
    try {
      log('Fetching file metadata from: $url');
      final response = await dio.head(url);

      if (response.statusCode == 200) {
        final metadata = {
          'Content-Disposition': response.headers.value('content-disposition')?.replaceFirst('filename=', ''),
          'contentType': response.headers.value('content-type'),
          'contentLength': response.headers.value('content-length'),
          'lastModified': response.headers.value('last-modified'),
        };
        log('File metadata fetched successfully: $metadata');
        return metadata;
      } else {
        log('Failed to fetch metadata, status code: ${response.statusCode}');
        throw Exception('Failed to fetch metadata');
      }
    } catch (e) {
      log('Error fetching file metadata: $e');
      throw Exception('Error fetching file metadata: $e');
    }
  }

  Future<String> uploadFile(String url, String filePath, {String? bearerToken}) async {
    final Dio dio = Dio();
    if (bearerToken != null) {
      dio.options.headers['Authorization'] = 'Bearer $bearerToken';
    }
    try {
      log('Uploading file to: $url');
      final response = await dio.post(
        url,
        data: FormData.fromMap({
          'file': await MultipartFile.fromFile(filePath),
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        log('File uploaded successfully: ${response.data}');
        return response.data.toString();
      } else {
        log('Failed to upload file, status code: ${response.statusCode}');
        throw Exception('Failed to upload file');
      }
    } catch (e) {
      log('Error uploading file: $e');
      throw Exception('Error uploading file: $e');
    }
  }

  Future<void> downloadFile(
    String url,
    String savePath, {
    String? bearerToken,
    void Function(int, int)? onReceiveProgress,
    CancelToken? cancelToken,
  }) async {
    final Dio dio = Dio();
    if (bearerToken != null) {
      dio.options.headers['Authorization'] = 'Bearer $bearerToken';
    }
    try {
      log('Downloading file from: $url');
      final File file = File(savePath);
      if (!await file.parent.exists()) {
        await file.parent.create(recursive: true);
      }
      final response = await dio.download(
        url,
        savePath,
        onReceiveProgress: onReceiveProgress,
        cancelToken: cancelToken,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        log('File downloaded successfully to: $savePath');
      } else {
        log('Failed to download file, status code: ${response.statusCode}');
        throw Exception('Failed to download file');
      }
    } catch (e) {
      log('Error downloading file: $e');

      throw Exception('Error downloading file: $e');
    }
  }
}
