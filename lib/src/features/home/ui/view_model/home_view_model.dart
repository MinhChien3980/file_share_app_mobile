part of '../../home.dart';

class HomeViewModel extends ViewModel {
  final repository = getIt<HomeRepository>();
  final _currentIndex = 0.obs;

  int get currentIndex => _currentIndex.value;
  final isLoading = true.obs;

  void changeIndex(int index) {
    print('HomeViewModel.changeIndex called with index: $index');
    print('Current index before change: ${_currentIndex.value}');
    _currentIndex.value = index;
    print('Current index after change: ${_currentIndex.value}');
    update();
  }

  @override
  void onInit() {
    super.onInit();
    _clearCachedState();
  }

  void _clearCachedState() {
    try {
      Get.delete<ExplorerViewModel>(force: true);
      Get.delete<PostSearchViewModel>(force: true);
      Get.delete<ProfileViewModel>(force: true);
    } catch (e) {
      // don't exist
    }

    Get.put<ExplorerViewModel>(ExplorerViewModel(), permanent: true);
    Get.put<PostSearchViewModel>(PostSearchViewModel(), permanent: true);
    Get.put<ProfileViewModel>(ProfileViewModel(), permanent: true);
  }

  @override
  void onReady() {
    super.onReady();

    Future.wait([
      getUser(),
    ]).whenComplete(() {
      isLoading.value = false;

      _forceUpdateChildViewModels();
    });
  }

  void _forceUpdateChildViewModels() {
    Future.delayed(const Duration(milliseconds: 200), () {
      try {
        final explorerVM = Get.find<ExplorerViewModel>();
        explorerVM.update();

        final downloadVM = Get.find<DownloadViewModel>();
        downloadVM.update();

        final profileVM = Get.find<ProfileViewModel>();
        profileVM.update();

        final searchVM = Get.find<PostSearchViewModel>();
        searchVM.update();

        update();
      } catch (e) {
        // not initialized
      }
    });
  }

  Future<void> getUser() async {
    runAction<Result<ProfileModel>>(
      () async {
        return await repository.getUser();
      },
      showLoading: true,
      onSuccess: (result) {
        result.when(
          success: (data) {
            Get.find<AppController>().setProfileSession(data);
          },
          failure: (error) {
            if (!(error.code == ErrorCode.network ||
                error.code == ErrorCode.timeout)) {
              Get.offAllNamed(RouterName.login);
            }
          },
        );
      },
      onError: (error) {
        Get.closeAllSnackbars();
        Get.snackbar(error.title ?? 'Error', error.message);
      },
    );
  }
}
