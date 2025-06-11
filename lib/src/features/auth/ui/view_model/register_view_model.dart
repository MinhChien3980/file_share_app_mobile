part of '../../auth.dart';

class RegisterViewModel extends ViewModel {
  final repository = getIt<AuthRepository>();
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final nameController = TextEditingController();
  final phoneNumberController = TextEditingController();

  final _visiblePassword = false.obs;
  bool get visiblePassword => _visiblePassword.value;
  void togglePasswordVisibility() {
    _visiblePassword.value = !_visiblePassword.value;
  }

  final _visibleConfirmPassword = false.obs;
  bool get visibleConfirmPassword => _visibleConfirmPassword.value;
  void toggleConfirmPasswordVisibility() {
    _visibleConfirmPassword.value = !_visibleConfirmPassword.value;
  }

  void register() {
    if (formKey.currentState!.validate()) {
      // Perform registration action
      final email = emailController.text;
      final password = passwordController.text;
      final name = nameController.text;
      final phoneNumber = phoneNumberController.text;

      runAction(
        () async {
          await repository.register(
            email: email,
            password: password,
            name: name,
            phoneNumber: phoneNumber,
          );
        },
        showLoading: true,
        onSuccess: (result) {
          // Handle successful registration
        },
        onError: (error) {
          showError(title: error.title, message: error.message);
        },
      );
    }
  }
}
