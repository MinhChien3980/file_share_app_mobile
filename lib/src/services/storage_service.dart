import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../features/download/download.dart';
import '../features/profile/profile.dart';

class StorageService {
  late final SharedPreferences _prefs;
  Future<StorageService> init() async {
    _prefs = await SharedPreferences.getInstance();
    return this;
  }

  bool get isFirstTime => _prefs.getBool(_StorageKey.isFirstTime) ?? true;
  Future setIsFirstTime(bool value) async =>
      await _prefs.setBool(_StorageKey.isFirstTime, value);
  bool get isLoggedIn => _prefs.getBool(_StorageKey.isLoggedIn) ?? false;
  Future setIsLoggedIn(bool value) async =>
      await _prefs.setBool(_StorageKey.isLoggedIn, value);
  String get userToken => _prefs.getString(_StorageKey.userToken) ?? '';
  Future setUserToken(String value) async =>
      await _prefs.setString(_StorageKey.userToken, value);
  String get fcmToken => _prefs.getString(_StorageKey.fcmToken) ?? '';
  Future setFcmToken(String value) =>
      _prefs.setString(_StorageKey.fcmToken, value);
  bool get enableNotification =>
      _prefs.getBool(_StorageKey.enableNotification) ?? false;
  Future setEnableNotification(bool enable) async =>
      await _prefs.setBool(_StorageKey.enableNotification, enable);

  Future<void> clearAllAppData() async {
    await _prefs.clear();
    // Reset all cached data
    await setIsFirstTime(true);
    await setIsLoggedIn(false);
    await setUserToken('');
    await setFcmToken('');
    await setEnableNotification(false);
  }

  Future<void> clear() async {
    await _prefs.clear();
    await setIsFirstTime(false);
  }

  Future<void> forceClear() async {
    await _prefs.clear();
  }

  void removeUserSession() {
    _prefs.remove(_StorageKey.userSession);
  }

  void setUserSession(ProfileModel session) {
    _prefs.setString(_StorageKey.userSession, jsonEncode(session.toJson()));
  }

  ProfileModel? get profileSession {
    final json = _prefs.getString(_StorageKey.userSession);
    if (json != null) {
      return ProfileModel.fromJson(jsonDecode(json));
    }
    return null;
  }

  List<DownloadTask> getDownloadTasks() {
    final tasksJson = _prefs.getStringList(_StorageKey.downloadTasks) ?? [];
    return tasksJson
        .map((taskJson) => DownloadTask.fromJson(jsonDecode(taskJson)))
        .toList();
  }

  Future<void> setDownloadTasks(List<DownloadTask> tasks) async {
    final tasksJson = tasks.map((task) => jsonEncode(task.toJson())).toList();
    await _prefs.setStringList(_StorageKey.downloadTasks, tasksJson);
  }
}

class _StorageKey {
  _StorageKey._();

  static String get isFirstTime => 'isFirstTime';
  static String get isLoggedIn => 'isLoggedIn';
  static String get userToken => 'userToken';
  static String get fcmToken => 'fcmToken';
  static String get enableNotification => 'enableNotification';
  static String get userSession => 'userSession';
  static String get downloadTasks => 'downloadTasks';
}
