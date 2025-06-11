part of '../../profile.dart';

class ChangePasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChangePasswordViewModel>(() => ChangePasswordViewModel());
  }
}
