part of '../../profile.dart';

class EditProfileArgs {
  final ProfileModel profile;

  EditProfileArgs(this.profile);
}

class EditProfileViewModel extends ViewModel {
  final _profileRepository = getIt<ProfileRepository>();

  final keyForm = GlobalKey<FormState>();
  final imageController = ImagePickInputController('');
  final usernameController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  final _profile = (Get.arguments as EditProfileArgs).profile;

  @override
  void onInit() {
    imageController.value = _profile.imageUrl ?? '';
    usernameController.text = _profile.login ?? '';
    firstNameController.text = _profile.firstName ?? '';
    lastNameController.text = _profile.lastName ?? '';
    emailController.text = _profile.email ?? '';
    phoneController.text = _profile.phoneNumber ?? '';
    super.onInit();
  }

  void onSubmitPress() {
    if (keyForm.currentState?.validate() ?? false) {
      String image = imageController.value ?? '';
      final firstName = firstNameController.text;
      final lastName = lastNameController.text;
      final email = emailController.text;
      final phone = phoneController.text;

      runAction<Result<ProfileModel>>(
        () async {
          File? imageFile;

          // Check if image is a local file path (not a URL)
          if (image.isNotEmpty && !image.startsWith('http')) {
            imageFile = File(image);
          }

          final result = await _profileRepository.updateProfile(
            firstName: firstName,
            lastName: lastName,
            email: email,
            phone: phone,
            imageFile: imageFile,
          );
          return result;
        },
        showLoading: true,
        onSuccess: (result) {
          if (result.isSuccess) {
            // Refresh the profile data on the profile page
            try {
              Get.find<ProfileViewModel>().refreshProfile();
            } catch (e) {
              // not initialized
              print(
                  'ProfileViewModel not found, will be refreshed when accessed');
            }

            Get.closeAllSnackbars();
            Get.snackbar(
              'Thành công',
              'Cập nhật hồ sơ thành công',
              duration: const Duration(seconds: 3),
              backgroundColor: Colors.green.shade100,
              colorText: Colors.green.shade800,
              icon: const Icon(Icons.check_circle, color: Colors.green),
            );

            // Navigate back to profile page
            Get.back();
          } else {
            Get.closeAllSnackbars();
            Get.snackbar(
              result.error?.title ?? 'Lỗi',
              result.error?.message ?? 'Không thể cập nhật hồ sơ',
              duration: const Duration(seconds: 3),
              backgroundColor: Colors.red.shade100,
              colorText: Colors.red.shade800,
              icon: const Icon(Icons.error, color: Colors.red),
            );
          }
        },
        onError: (error) {
          Get.closeAllSnackbars();
          Get.snackbar(
            error.title ?? 'Lỗi',
            error.message ?? 'Đã xảy ra lỗi không mong muốn',
            duration: const Duration(seconds: 3),
            backgroundColor: Colors.red.shade100,
            colorText: Colors.red.shade800,
            icon: const Icon(Icons.error, color: Colors.red),
          );
        },
      );
    }
  }
}
