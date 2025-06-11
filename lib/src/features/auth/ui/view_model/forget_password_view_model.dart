part of '../../auth.dart';

class ForgetPasswordViewModel extends ViewModel {
  final AuthRepository _authRepository = getIt<AuthRepository>();
  final AuthViewModel _authViewModel = Get.find<AuthViewModel>();

  final TextEditingController emailController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();

  @override
  void onInit() {
    super.onInit();
    emailFocusNode.addListener(() {
      if (emailFocusNode.hasFocus) {
        // Handle focus gained
      } else {
        // Handle focus lost
      }
    });
  }

  @override
  void onClose() {
    emailController.dispose();
    emailFocusNode.dispose();
    super.onClose();
  }
}
