part of '../../onboard.dart';

@lazySingleton
class OnboardRepository {
  final _storage = getIt<StorageService>();

  Future<bool> setFinish() async {
    final isFirstTime = await _storage.setIsFirstTime(false);
    if (isFirstTime == null) {
      return true;
    }
    return isFirstTime;
  }
}
