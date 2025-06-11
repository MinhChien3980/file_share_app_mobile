part of '../../post.dart';

class PostDetailArgs {
  final PostModel postDetail;
  PostDetailArgs(this.postDetail);
}

class PostDetailViewModel extends ViewModel {
  final _postRepository = getIt<PostRepository>();
  final PostModel postDetail = (Get.arguments as PostDetailArgs).postDetail;
  final RxList<MetaDataFile> _fileInPost = <MetaDataFile>[].obs;
  List<MetaDataFile> get fileInPost => _fileInPost;

  @override
  void onInit() {
    _fetchFilesInPost();
    super.onInit();
  }

  void _fetchFilesInPost() {
    runAction<Result<List<MetaDataFile>>>(
      () async {
        return await _postRepository.getFilesInPost(postDetail.files ?? []);
      },
      onSuccess: (data) {
        data.when(
          success: (data) {
            _fileInPost.value = data;
          },
          failure: (error) {
            Get.closeAllSnackbars();
            Get.snackbar('Error', error.message);
          },
        );
      },
      onError: (error) {
        Get.closeAllSnackbars();
        Get.snackbar(error.title ?? 'Error', error.message);
      },
    );
  }

  Future<void> downloadFile(String url) async {
    print('Downloading file from URL: $url');
    if (url.isEmpty) {
      Get.closeAllSnackbars();
      Get.snackbar('Error', 'File URL is empty');
      return;
    }
    final downloadPath = await getDownloadDirectory();
    if (downloadPath.isEmpty) {
      Get.closeAllSnackbars();
      Get.snackbar('Error', 'Please allow storage permission to download files.');
      return;
    }
    final shareDocsPath = '$downloadPath/ShareDocs';
    final shareDocsDir = Directory(shareDocsPath);
    if (!await shareDocsDir.exists()) {
      await shareDocsDir.create(recursive: true);
    }

    Get.find<DownloadViewModel>().addDownloadTask(
      DownloadTask(
        url: url,
        fileName: url.split('/').last,
        localPath: '$shareDocsPath/${url.split('/').last}',
      ),
    );
  }

  Future<String> getDownloadDirectory() async {
    if (Platform.isAndroid) {
      await [
        Permission.photos,

        Permission.storage,
        Permission.manageExternalStorage, // For Android 11 and above
      ].request();
    } else if (Platform.isIOS) {
      await Permission.storage.request();
    }

    String downloadPath = await ExternalPath.getExternalStoragePublicDirectory(
      ExternalPath.DIRECTORY_DOWNLOAD,
    );
    return downloadPath;
  }
}
