part of '../../post.dart';

class PostSearchPage extends BaseView<PostSearchViewModel> {
  const PostSearchPage({super.key});

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search post'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: SearchBar(
                controller: viewModel.searchController,
                onSubmitted: viewModel.onSearchSubmitted,
              ),
            ),
            Expanded(
              child: Obx(() {
                if (viewModel.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (viewModel.searchResults.isEmpty &&
                    viewModel.searchController.text.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search,
                          size: 100,
                          color: Colors.grey.shade400,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Search for posts',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  );
                }
                if (viewModel.searchResults.isEmpty) {
                  return Center(
                    child: Text(
                      'No results found',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  );
                }
                return RefreshIndicator(
                  onRefresh: viewModel.refresh,
                  backgroundColor: Colors.white,
                  color: Theme.of(context).primaryColor,
                  strokeWidth: 3.0,
                  child: ListView.separated(
                    separatorBuilder: (context, index) => Divider(
                      color: Colors.grey.shade300,
                      height: 1,
                    ),
                    itemCount: viewModel.searchResults.length + 1,
                    itemBuilder: (context, index) {
                      if (index == viewModel.searchResults.length) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextButton(
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.all(16),
                              tapTargetSize: MaterialTapTargetSize.padded,
                            ),
                            onPressed: viewModel.loadMore,
                            child: const Text('Load More'),
                          ),
                        );
                      }
                      final post = viewModel.searchResults[index];
                      return PostCard(
                        post: post,
                        onLike: (isLike) {},
                      );
                    },
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final Function(String)? onSubmitted;

  const SearchBar({
    super.key,
    required this.controller,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: 'search'.tr,
        prefixIcon: const Icon(Icons.search),
        suffixIcon: IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            controller.clear();
            if (onSubmitted != null) {
              onSubmitted!('');
            }
          },
        ),
        border: const OutlineInputBorder(),
      ),
      onSubmitted: onSubmitted,
      textInputAction: TextInputAction.search,
      onChanged: (value) {
        if (onSubmitted != null) {
          onSubmitted!(value);
        }
      },
      style: Theme.of(context).textTheme.bodyLarge,
    );
  }
}
