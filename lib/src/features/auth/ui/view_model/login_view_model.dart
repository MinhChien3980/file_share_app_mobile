part of '../../auth.dart';

class LoginViewModel extends ViewModel {
  final repository = getIt<AuthRepository>();

  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  final _visiblePassword = false.obs;
  bool get visiblePassword => _visiblePassword.value;

  void togglePasswordVisibility() {
    _visiblePassword.value = !_visiblePassword.value;
  }

  Future<void> login() async {
    if (formKey.currentState!.validate()) {
      // Perform login action
      final username = usernameController.text;
      final password = passwordController.text;

      runAction<Result<AuthModel>>(
        () async {
          return await repository.login(
            username: username,
            password: password,
          );
        },
        showLoading: true,
        onSuccess: (result) {
          // Handle successful login
          result.when(
            success: (data) {
              Get.offAllNamed(RouterName.home);
            },
            failure: (error) {
              // Handle error
              if (error.fieldErrors != null && error.fieldErrors!.isNotEmpty) {
                final firstFieldError = error.fieldErrors!.first;

                if (firstFieldError.field == 'username') {
                  showError(
                    title: 'Username Error',
                    message: firstFieldError.message,
                  );
                } else if (firstFieldError.field == 'password') {
                  showError(
                    title: 'Password Error',
                    message: firstFieldError.message,
                  );
                }
              } else {
                showError(
                  title: error.title,
                  message: error.message,
                );
              }
            },
          );
        },
        onError: (error) {
          // Handle error
          showError(
            title: error.title,
            message: error.message,
          );
        },
      );
    }
  }

  void loginWithGoogle() {
    runAction<Result<AuthModel>>(
      () async {
        return await repository.loginWithGoogle();
      },
      showLoading: true,
      onSuccess: (result) {
        // Handle successful login with Google
        result.when(
          success: (data) {
            Get.offAllNamed(RouterName.home);
          },
          failure: (error) {
            // Handle error
            showError(
              title: error.title,
              message: error.message,
            );
          },
        );
      },
      onError: (error) {
        // Handle error
        showError(
          title: error.title,
          message: error.message,
        );
      },
    );
  }
}
