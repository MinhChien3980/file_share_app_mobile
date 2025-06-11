part of '../../profile.dart';

class EditProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditProfileViewModel>(() => EditProfileViewModel());
  }
}
