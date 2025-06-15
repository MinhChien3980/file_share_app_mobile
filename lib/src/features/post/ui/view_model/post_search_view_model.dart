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
  bool isTagSearch = true; // Always use tag search for this page

  void onSearchSubmitted(String query) {
    if (query.isEmpty || query.isEmpty) return;
    currentQuery = query;
    page = 0;
    _debouncer.call(() {
      _searchPostsByTags(tags: query);
    });
  }

  void _searchPostsByTags({required String tags, int page = 0}) {
    isLoading.value = true;
    runAction<Result<List<PostModel>>>(
      () async {
        return await _postRepository.searchPostsByTags(
          tags: tags,
          page: page,
          size: 20,
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
      if (currentQuery.isNotEmpty) {
        page++;
        _searchPostsByTags(tags: currentQuery, page: page);
      }
    });
  }

  // Method for pull-to-refresh functionality
  @override
  Future<void> refresh() async {
    if (currentQuery.isNotEmpty) {
      page = 0;
      _searchResults.clear();
      _searchPostsByTags(tags: currentQuery, page: 0);
    }
  }
}
