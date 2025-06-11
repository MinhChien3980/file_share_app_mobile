part of '../../home.dart';

class HomePage extends BaseView<HomeViewModel> {
  const HomePage({super.key});

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          print(
              'HomePage body rebuild - currentIndex: ${viewModel.currentIndex}');
          return viewModel.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : _HomeContent(
                  currentIndex: viewModel.currentIndex,
                );
        },
      ),
      bottomNavigationBar: Obx(
        () {
          print(
              'BottomNavigationBar rebuild - currentIndex: ${viewModel.currentIndex}');
          return BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: [
              const BottomNavigationBarItem(
                  icon: Icon(Icons.home), label: 'Home'),
              const BottomNavigationBarItem(
                  icon: Icon(Icons.search), label: 'Search'),
              const BottomNavigationBarItem(
                  icon: Icon(Icons.download), label: 'Downloads'),
              const BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle), label: 'Profile'),
            ],
            currentIndex:
                viewModel.currentIndex.clamp(0, 3), // Ensure valid range
            onTap: (index) {
              print(
                  'Bottom nav tapped: $index (current: ${viewModel.currentIndex})');
              viewModel.changeIndex(index);
            },
          );
        },
      ),
    );
  }
}

class _HomeContent extends StatefulWidget {
  final int currentIndex;

  const _HomeContent({
    required this.currentIndex,
  });

  @override
  State<_HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<_HomeContent> {
  @override
  void initState() {
    super.initState();
    print('_HomeContentState initState - currentIndex: ${widget.currentIndex}');
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeAllViewModels();
    });
  }

  void _initializeAllViewModels() {
    try {
      final explorerVM = Get.find<ExplorerViewModel>();
      if (explorerVM.posts.isEmpty) {
        explorerVM.fetchPosts();
      }
    } catch (e) {
      print('Error initializing ExplorerViewModel: $e');
    }
  }

  @override
  void didUpdateWidget(_HomeContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.currentIndex != oldWidget.currentIndex) {
      print(
          '_HomeContent didUpdateWidget - old: ${oldWidget.currentIndex}, new: ${widget.currentIndex}');
    }
  }

  @override
  Widget build(BuildContext context) {
    print('_HomeContent build - currentIndex: ${widget.currentIndex}');
    return IndexedStack(
      index: widget.currentIndex.clamp(0, 3),
      children: [
        _buildExplorerTab(),
        _buildSearchTab(),
        _buildDownloadTab(),
        _buildProfileTab(),
      ],
    );
  }

  Widget _buildExplorerTab() {
    return GetBuilder<ExplorerViewModel>(
      init: Get.find<ExplorerViewModel>(),
      builder: (_) => const ExplorerPage(),
    );
  }

  Widget _buildSearchTab() {
    return GetBuilder<PostSearchViewModel>(
      init: Get.find<PostSearchViewModel>(),
      builder: (_) => const PostSearchPage(),
    );
  }

  Widget _buildDownloadTab() {
    return GetBuilder<DownloadViewModel>(
      init: Get.find<DownloadViewModel>(),
      builder: (_) => const DownloadPage(),
    );
  }

  Widget _buildProfileTab() {
    return GetBuilder<ProfileViewModel>(
      init: Get.find<ProfileViewModel>(),
      builder: (_) => const ProfilePage(),
    );
  }
}
