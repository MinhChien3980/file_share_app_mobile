part of '../../profile.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ProfileViewModel>(ProfileViewModel(), permanent: true);
  }
}
