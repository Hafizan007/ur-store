part of 'app_initial_sources.dart';

abstract class AppInitial {
  AppInitial() {
    _init();
  }

  FutureOr<StatefulWidget> onCreate();

  void _init() {
    runZonedGuarded(() async {
      WidgetsFlutterBinding.ensureInitialized();

      await AppEnvironment().getCurrentEnv();
      configureInjection();

      await Hive.initFlutter();
      Hive.registerAdapter(UserLocalModelAdapter());

      final app = await onCreate();
      runApp(app);
    }, (error, stack) {
      debugPrint("$error: $stack");
    });
  }
}
