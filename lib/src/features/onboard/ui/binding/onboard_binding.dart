part of '../../onboard.dart';

class OnboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnboardViewModel>(() => OnboardViewModel());
  }
}
