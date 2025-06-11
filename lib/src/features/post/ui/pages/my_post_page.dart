part of '../../post.dart';

class MyPostPage extends BaseView<MyPostViewModel> {
  const MyPostPage({super.key});

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Posts'),
      ),
      body: Obx(
        () {
          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (viewModel.posts.isEmpty) {
            return RefreshIndicator(
              onRefresh: () async {
                await viewModel.refreshPosts();
              },
              backgroundColor: Colors.white,
              color: Theme.of(context).primaryColor,
              strokeWidth: 3.0,
              child: ListView(
                children: const [
                  SizedBox(height: 200),
                  Center(child: Text('No posts found.')),
                ],
              ),
            );
          }
          return RefreshIndicator(
            onRefresh: () async {
              await viewModel.refreshPosts();
            },
            backgroundColor: Colors.white,
            color: Theme.of(context).primaryColor,
            strokeWidth: 3.0,
            child: ListView.builder(
              itemCount: viewModel.posts.length,
              itemBuilder: (context, index) {
                final post = viewModel.posts[index];
                return PostCard(
                  post: post,
                  onLike: (isLike) {},
                  onTap: () {
                    Get.toNamed(RouterName.postDetail,
                        arguments: PostDetailArgs(post));
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
