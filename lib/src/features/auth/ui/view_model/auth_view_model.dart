part of '../../auth.dart';

class AuthViewModel extends ViewModel {
  final repository = getIt<AuthRepository>();

  @override
  void onClose() {
    Get.delete<LoginViewModel>();
    Get.delete<RegisterViewModel>();
    Get.delete<ForgetPasswordViewModel>();
    super.onClose();
  }
}
