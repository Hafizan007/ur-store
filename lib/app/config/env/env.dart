import 'package:envied/envied.dart';
import 'package:package_info_plus/package_info_plus.dart';

part 'env.g.dart';

@Envied(path: ".dev.env", obfuscate: true)
abstract class DevEnv {
  @EnviedField(varName: 'BASE_URL')
  static String baseUrl = _DevEnv.baseUrl;
}

@Envied(path: ".prod.env", obfuscate: true)
abstract class ProdEnv {
  @EnviedField(varName: 'BASE_URL')
  static String baseUrl = _ProdEnv.baseUrl;
}

enum EnvironmentType { dev, prod }

class AppEnvironment {
  static final AppEnvironment _singleton = AppEnvironment._internal();

  factory AppEnvironment() => _singleton;

  AppEnvironment._internal();

  static late EnvironmentType _currentEnv;

  EnvironmentType get currentEnv => _currentEnv;

  Future<void> getCurrentEnv() async {
    final packageInfo = await PackageInfo.fromPlatform();
    switch (packageInfo.packageName) {
      case "com.urstore.app.dev":
        _currentEnv = EnvironmentType.dev;
        break;
      case "com.urstore.app":
        _currentEnv = EnvironmentType.prod;
        break;
      default:
        _currentEnv = EnvironmentType.dev;
    }
  }
}
