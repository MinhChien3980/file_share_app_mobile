import 'dart:developer';

import 'package:file_share_app/injector.dart';
import 'package:file_share_app/src/features/profile/profile.dart';
import 'package:get/get.dart';

import '../../services/storage_service.dart';

class AppController extends GetxController {
  final _profileSession = Rxn<ProfileModel>();
  final _storage = getIt<StorageService>();
  ProfileModel? get userSession => _profileSession.value;

  late final Worker _userWorker;
  @override
  void onInit() {
    if (userSession != null) {
      _profileSession.value = userSession;
    }
    _userWorker = ever(_profileSession, (ProfileModel? session) {
      log('User session changed: ${session?.toJson() ?? 'null'}');
      if (session != null) {
        _storage.setUserSession(session);
      } else {
        _storage.removeUserSession();
      }
    });

    super.onInit();
  }

  @override
  void onClose() {
    _userWorker.dispose();
    super.onClose();
  }

  void setProfileSession(ProfileModel? session) {
    _profileSession.value = session;
  }
}
