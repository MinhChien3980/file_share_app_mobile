part of '../../post.dart';

class ExplorerViewModel extends ViewModel {
  final _explorerRepository = getIt<PostRepository>();
  int page = 0;
  final RxList<PostModel> _posts = <PostModel>[].obs;
  List<PostModel> get posts => _posts;
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  final _isLoadingMore = false.obs;
  bool get isLoadingMore => _isLoadingMore.value;

  @override
  void onReady() {
    super.onReady();
    clearCacheAndRefresh();
  }

  void clearCacheAndRefresh() {
    CacheInterceptor.clearCacheForUrl('/posts');

    page = 0;
    _posts.clear();
    _isLoading.value = false;
    _isLoadingMore.value = false;

    update();

    Future.delayed(const Duration(milliseconds: 100), () {
      fetchPosts(refresh: true);
    });
  }

  void fetchPosts({bool refresh = false}) {
    if (refresh) {
      page = 0;
      _posts.clear();
    } else if (_isLoadingMore.value) {
      return;
    }

    _isLoadingMore.value = true;

    runAction<Result<List<PostModel>>>(
      () async {
        return await _explorerRepository.getPosts(
            page: page, size: 10, sort: 'createdAt,desc');
      },
      beforeAction: () {
        _isLoading.value = true;
      },
      onSuccess: (data) {
        data.when(
          success: (data) {
            if (data.isNotEmpty) {
              if (refresh) {
                _posts.assignAll(data);
              } else {
                _posts.addAll(data);
              }
              page++;
            }
            // Force UI update
            update();
          },
          failure: (error) {
            Get.closeAllSnackbars();
            Get.snackbar('Error', error.message);
          },
        );
        _isLoading.value = false;
        _isLoadingMore.value = false;
        update();
      },
      onError: (error) {
        Get.closeAllSnackbars();
        Get.snackbar(error.title ?? 'Error', error.message);
        _isLoading.value = false;
        _isLoadingMore.value = false;
        update();
      },
    );
  }

  Future<void> refreshPosts() async {
    page = 0;
    _posts.clear();
    _isLoading.value = true;

    try {
      final result = await _explorerRepository.getPosts(
          page: 0, size: 10, sort: 'createdAt,desc');
      result.when(
        success: (data) {
          _posts.assignAll(data);
          page = 1;
          update();
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
      Get.snackbar('Error', 'Failed to refresh posts');
    } finally {
      _isLoading.value = false;
      update();
    }
  }
}
