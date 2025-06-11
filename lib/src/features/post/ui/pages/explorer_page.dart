part of '../../post.dart';

class ExplorerPage extends BaseView<ExplorerViewModel> {
  const ExplorerPage({super.key});

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Explorer'),
        toolbarHeight: 0,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await viewModel.refreshPosts();
        },
        backgroundColor: Colors.white,
        color: Theme.of(context).primaryColor,
        strokeWidth: 3.0,
        displacement: 40.0,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  'Explore',
                  style: text36.bold,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: _SearchBar(viewModel: viewModel),
              ),
            ),
            GetBuilder<ExplorerViewModel>(
              builder: (controller) => SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final post = controller.posts[index];
                    return PostCard(
                      post: post,
                      onLike: (isLike) {},
                      onTap: () {
                        Get.toNamed(RouterName.postDetail,
                            arguments: PostDetailArgs(post));
                      },
                    );
                  },
                  childCount: controller.posts.length,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: GetBuilder<ExplorerViewModel>(
                  builder: (controller) => controller.posts.isEmpty
                      ? const Center(child: Text('No posts found'))
                      : TextButton(
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.all(16),
                            tapTargetSize: MaterialTapTargetSize.padded,
                          ),
                          onPressed: () {
                            controller.fetchPosts();
                          },
                          child: const Text('Load More'),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar({
    required this.viewModel,
  });

  final ExplorerViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          Get.find<HomeViewModel>().changeIndex(1);
        },
        child: IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(
                  Get.find<AppController>().userSession?.imageUrl ?? '',
                ),
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Text('Search....'),
                    ),
                    SizedBox(width: 10),
                    Icon(Icons.search),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: secondaryColor,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                onPressed: () {
                  Get.toNamed(RouterName.createPost);
                },
                child: const Text('Create Post'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
