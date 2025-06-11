part of '../../splash.dart';

class SplashViewModel extends ViewModel {
  final _repository = getIt<SplashRepository>();

  @override
  void onReady() {
    super.onReady();
    Future.delayed(const Duration(seconds: 2), () {
      _checkApp();
    });
  }

  void _checkApp() {
    final appInit = _repository.getAppInitStatus();

    if (appInit.isFirstTime) {
      // Navigate to onboarding
      Get.offAllNamed(RouterName.onBoard);
    } else if (appInit.isLoggedIn) {
      Get.offAllNamed(RouterName.home);
    } else {
      // Navigate to login
      Get.offAllNamed(RouterName.auth);
    }
  }
}
