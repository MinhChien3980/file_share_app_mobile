part of '../../profile.dart';

class ProfilePage extends BaseView<ProfileViewModel> {
  const ProfilePage({super.key});

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Hồ sơ của bạn',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
            // Add more slivers or widgets as needed
            SliverToBoxAdapter(
              child: Obx(() => viewModel.profile != null
                  ? _ProfileHeader(viewModel: viewModel)
                  : const SizedBox.shrink()),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 20),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text('Bài viết của tôi', style: text16.regular),
                        leading: const Icon(Icons.post_add),
                        onTap: () {
                          Get.toNamed(RouterName.myPosts);
                        },
                      ),
                      Divider(
                        color: Colors.grey.shade300,
                        height: 1,
                      ),
                      ListTile(
                        title: Text('Đổi mật khẩu', style: text16.regular),
                        leading: const Icon(Icons.lock_outline),
                        onTap: () {
                          Get.toNamed(RouterName.changePassword);
                        },
                      ),
                      Divider(
                        color: Colors.grey.shade300,
                        height: 1,
                      ),
                      ListTile(
                        title: Text('Giới thiệu', style: text16.regular),
                        leading: const Icon(Icons.info_outline),
                        onTap: () {
                          // Get.toNamed(RouterName.about);
                          Get.to(const HtmlPage(
                              htmlUrl: 'https://flutter.dev',
                              pageTitle: 'Giới thiệu'));
                        },
                      ),
                      Divider(
                        color: Colors.grey.shade300,
                        height: 1,
                      ),
                      ListTile(
                        title: Text('Help', style: text16.regular),
                        leading: const Icon(Icons.help_outline),
                        onTap: () {
                          Get.to(const HtmlPage(
                              htmlUrl: 'https://flutter.dev',
                              pageTitle: 'About Me'));
                        },
                      ),
                      Divider(
                        color: Colors.grey.shade300,
                        height: 1,
                      ),
                      ListTile(
                        title: Text('Privacy Policy', style: text16.regular),
                        leading: const Icon(Icons.privacy_tip_outlined),
                        onTap: () {
                          Get.to(const HtmlPage(
                              htmlUrl: 'https://flutter.dev',
                              pageTitle: 'About Me'));
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 30),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  onPressed: () {
                    viewModel.logOut();
                  },
                  child: const Text(
                    'Logout',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 20),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({
    required this.viewModel,
  });

  final ProfileViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                if (viewModel.profile?.imageUrl != null) {
                  FullScreenImageViewer.show(
                    imageUrl: viewModel.profile!.imageUrl!,
                    title: 'Ảnh đại diện',
                    heroTag: 'profile_avatar',
                  );
                }
              },
              child: Hero(
                tag: 'profile_avatar',
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(viewModel.profile?.imageUrl ??
                      'https://images.pexels.com/photos/12341218/pexels-photo-12341218.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${viewModel.profile?.firstName ?? 'Họ'} ${viewModel.profile?.lastName ?? 'Tên'}',
                  style: text24.semiBold.black,
                ),
                Text(
                  viewModel.profile?.email ?? 'Chưa có email',
                  style: text16.regular.grey,
                ),
              ],
            ),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                if (viewModel.profile != null) {
                  Get.toNamed(RouterName.editProfile,
                      arguments: EditProfileArgs(viewModel.profile!));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
