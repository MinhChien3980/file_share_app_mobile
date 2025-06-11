part of '../../profile.dart';

class ChangePasswordViewModel extends ViewModel {
  final _profileRepository = getIt<ProfileRepository>();

  final formKey = GlobalKey<FormState>();
  final TextEditingController currentPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  final _visiblePassword = false.obs;
  bool get visiblePassword => _visiblePassword.value;

  void toggleVisiblePassword() {
    _visiblePassword.value = !_visiblePassword.value;
  }

  final _visibleNewPassword = false.obs;
  bool get visibleNewPassword => _visibleNewPassword.value;
  void toggleVisibleNewPassword() {
    _visibleNewPassword.value = !_visibleNewPassword.value;
  }

  final _visibleConfirmPassword = false.obs;
  bool get visibleConfirmPassword => _visibleConfirmPassword.value;
  void toggleVisibleConfirmPassword() {
    _visibleConfirmPassword.value = !_visibleConfirmPassword.value;
  }

  @override
  void onClose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  void onSubmitPress() {
    if (formKey.currentState?.validate() ?? false) {
      final currentPassword = currentPasswordController.text;
      final newPassword = newPasswordController.text;

      runAction<Result<ProfileModel>>(
        () async {
          final result = await _profileRepository.changePassword(currentPassword, newPassword);
          return result;
        },
        onSuccess: (result) {
          if (result.isSuccess) {
            Get.closeAllSnackbars();
            Get.snackbar('Success', 'Password changed successfully');
            Get.back();
          } else {
            Get.closeAllSnackbars();
            Get.snackbar(
              result.error?.title ?? 'Error',
              result.error?.message ?? 'Failed to change password',
            );
          }
        },
      );
    }
  }
}
