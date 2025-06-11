part of 'config.dart';

class AppConfig {
  AppConfig._();

  static Duration get defaultTimeout => const Duration(seconds: 30);
  static Duration get transitionTimeIn => const Duration(milliseconds: 500);
  static Duration get transitionTimeOut => const Duration(milliseconds: 250);

  static Locale get defaultLocale => const Locale('en', 'US');
  static String get defaultLanguage => 'en';

  static List<Locale> get supportedLocales => [
        const Locale('en', 'US'),
        const Locale('vi', 'VN'),
      ];

  static String get appVersion => '1.0.0';
}
