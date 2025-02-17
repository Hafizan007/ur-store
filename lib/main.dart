import 'dart:async';

import 'package:flutter/material.dart';

import 'app/config/env/app_initial_sources.dart';
import 'app/my_app.dart';

void main() => Main();

class Main extends AppInitial {
  @override
  FutureOr<StatefulWidget> onCreate() {
    ErrorWidget.builder = (details) {
      Zone.current.handleUncaughtError(details.exception, details.stack!);
      return const SizedBox.shrink();
    };
    return const MyApp();
  }
}
