part of '../../auth.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AuthViewModel>(AuthViewModel());
    Get.put<LoginViewModel>(LoginViewModel(), permanent: true);
    Get.put<RegisterViewModel>(RegisterViewModel(), permanent: true);
    Get.put<ForgetPasswordViewModel>(ForgetPasswordViewModel(), permanent: true);
  }
}
