part of '../../post.dart';

class PostSearchViewModel extends ViewModel {
  final PostRepository _postRepository = getIt<PostRepository>();

  final searchController = TextEditingController();
  final RxList<PostModel> _searchResults = <PostModel>[].obs;
  List<PostModel> get searchResults => _searchResults;
  final RxBool isLoading = false.obs;
  String currentQuery = '';
  int page = 0;
  final Debouncer _debouncer =
      Debouncer(delay: const Duration(milliseconds: 500));

  void onSearchSubmitted(String query) {
    if (query.isEmpty || query.length <= 2) return;
    currentQuery = query;
    page = 0;
    _debouncer.call(() {
      _searchPosts(query: query);
    });
  }

  void _searchPosts({required String query, int page = 0}) {
    isLoading.value = true;
    runAction<Result<List<PostModel>>>(
      () async {
        return await _postRepository.searchPosts(
            query: query,
            page: page,
            sort: 'createdAt,desc' // Sort by creation date, newest first
            );
      },
      onSuccess: (data) {
        data.when(success: (data) {
          if (page == 0) {
            _searchResults.value = data;
          } else {
            _searchResults.addAll(data);
          }
        }, failure: (error) {
          Get.closeAllSnackbars();
          Get.snackbar('Error', error.message);
        });
      },
      onError: (error) {
        Get.closeAllSnackbars();
        Get.snackbar(error.title ?? 'Error', error.message);
      },
    );
    isLoading.value = false;
  }

  void loadMore() {
    if (isLoading.value) return;
    _debouncer.call(() {
      if (currentQuery.isNotEmpty && currentQuery.length > 2) {
        page++;
        _searchPosts(query: currentQuery, page: page);
      }
    });
  }

  // Method for pull-to-refresh functionality
  @override
  Future<void> refresh() async {
    if (currentQuery.isNotEmpty && currentQuery.length > 2) {
      page = 0;
      _searchResults.clear();
      _searchPosts(query: currentQuery, page: 0);
    }
  }
}
