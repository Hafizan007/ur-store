import '../env/env.dart';

class AppNetwork {
  static final AppNetwork _singleton = AppNetwork._internal();

  factory AppNetwork() => _singleton;

  AppNetwork._internal();

  String get baseUrl => _getbaseUrlBasedOnEnv();

  String _getbaseUrlBasedOnEnv() {
    final currentEnv = AppEnvironment().currentEnv;

    if (currentEnv == EnvironmentType.dev) {
      return DevEnv.baseUrl;
    } else if (currentEnv == EnvironmentType.prod) {
      return ProdEnv.baseUrl;
    } else {
      return ProdEnv.baseUrl;
    }
  }

  static const Duration receiveTimeout = Duration(seconds: 10);

  static const Duration connectionTimeout = Duration(seconds: 10);
}
