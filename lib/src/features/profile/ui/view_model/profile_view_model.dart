part of '../../profile.dart';

class ProfileViewModel extends ViewModel {
  final _profileRepository = getIt<ProfileRepository>();

  final _profile = Rx<ProfileModel?>(null);

  ProfileModel? get profile => _profile.value;

  @override
  void onInit() {
    _fetchProfile();
    super.onInit();
  }

  void logOut() {
    getIt<StorageService>().clear();
    Get.find<AppController>().setProfileSession(null);

    Get.offAllNamed(RouterName.auth);
  }

  ProfileModel? get userProfile => Get.find<AppController>().userSession;

  void refreshProfile() {
    _fetchProfile();
  }

  void _fetchProfile() {
    runAction<Result<ProfileModel>>(
      () async {
        return await _profileRepository.getProfile();
      },
      onSuccess: (data) {
        data.when(success: (data) {
          print('Profile fetched successfully: ${data.toJson()}');
          _profile.value = data;
        }, failure: (error) {
          print('Error fetching profile: ${error.message}');
          Get.closeAllSnackbars();
          Get.snackbar('Error', error.message);
        });
      },
      onError: (error) {
        Get.closeAllSnackbars();
        Get.snackbar(error.title ?? 'Error', error.message);
      },
    );
  }
}
