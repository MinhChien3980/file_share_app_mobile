part of '../../onboard.dart';

class OnboardViewModel extends ViewModel {
  final _repository = getIt<OnboardRepository>();

  final _currentPage = 0.obs;
  int get currentPage => _currentPage.value;

  final pageController = PageController();

  void changePage(int page) {
    _currentPage.value = page;

    pageController.animateToPage(
      page,
      duration: AppConfig.transitionTimeIn,
      curve: Curves.easeIn,
    );
  }

  void finishOnboarding() {
    _repository.setFinish();
    Get.offAllNamed(RouterName.auth);
  }

  bool get isLastPage => _currentPage.value == 2;
}
