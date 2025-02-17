import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'config/injection/injection.dart';
import 'config/router/router.dart';
import 'config/themes/app_theme.dart';
import 'constants/app_constant.dart';
import 'features/cart/presentation/cubit/cart_cubit.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final cartCubit = getIt<CartCubit>();
  final appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cartCubit,
      child: MaterialApp.router(
        title: AppConstant.appName,
        theme: getApplicationTheme(),
        debugShowCheckedModeBanner: false,
        routerDelegate: appRouter.delegate(),
        locale: const Locale('en'),
        routeInformationParser: appRouter.defaultRouteParser(),
      ),
    );
  }
}
