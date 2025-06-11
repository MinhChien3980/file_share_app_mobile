part of '../../splash.dart';

@lazySingleton
class SplashRepository {
  final _storage = getIt<StorageService>();

  AppInit getAppInitStatus() {
    final isFirstTime = _storage.isFirstTime;
    final isLoggedIn = _storage.isLoggedIn && _storage.userToken.isNotEmpty;

    return AppInit(
      isFirstTime: isFirstTime,
      isLoggedIn: isLoggedIn,
    );
  }
}
