part of '../../post.dart';

class MyPostViewModel extends ViewModel {
  final _postRepository = getIt<PostRepository>();
  int page = 0;
  final RxList<PostModel> _posts = <PostModel>[].obs;
  List<PostModel> get posts => _posts;
  final _isLoading = true.obs;
  bool get isLoading => _isLoading.value;
  final _isLoadingMore = false.obs;
  bool get isLoadingMore => _isLoadingMore.value;

  @override
  void onInit() {
    fetchPosts();
    super.onInit();
  }

  void fetchPosts({bool refresh = false}) {
    if (refresh) {
      page = 0;
      posts.clear();
    } else if (isLoadingMore) {
      return; // Prevent multiple fetches
    }

    runAction<Result<List<PostModel>>>(
      () async {
        return await _postRepository.getMyPosts(page: page, size: 10);
      },
      beforeAction: () {
        _isLoading.value = true;
      },
      onSuccess: (data) {
        data.when(
          success: (data) {
            posts.addAll(data);
            page++;
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
    _isLoading.value = false;
  }

  // Method for pull-to-refresh functionality
  Future<void> refreshPosts() async {
    page = 0;
    _posts.clear();
    _isLoading.value = true; // Show loading state during refresh

    try {
      // Fetch my posts with newest first sorting
      final result = await _postRepository.getMyPosts(page: 0, size: 10);
      result.when(
        success: (data) {
          _posts.value = data;
          page = 1; // Set to 1 since we've loaded the first page
          Get.closeAllSnackbars();
          Get.snackbar('Refreshed', 'Latest posts loaded successfully',
              duration: const Duration(seconds: 1));
        },
        failure: (error) {
          Get.closeAllSnackbars();
          Get.snackbar('Error', error.message);
        },
      );
    } catch (e) {
      Get.closeAllSnackbars();
      Get.snackbar('Error', 'Failed to refresh my posts');
    } finally {
      _isLoading.value = false; // Hide loading state
    }
  }
}
