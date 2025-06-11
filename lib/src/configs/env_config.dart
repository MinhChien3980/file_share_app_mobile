part of 'config.dart';

class EnvConfig {
  EnvConfig._();
  static String get flavor => dotenv.env['FLAVOR']!;
  static String get baseUrl => dotenv.env['BASE_URL']!;
}
