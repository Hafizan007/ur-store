import 'package:auto_route/auto_route.dart';

import 'app_router.gr.dart';

@AutoRouterConfig(
  replaceInRouteName: 'Page,Route',
)
class AppRouter extends $AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.custom(
        transitionsBuilder: TransitionsBuilders.slideLeft,
        durationInMilliseconds: 100,
      );
  @override
  final List<AutoRoute> routes = [
    AutoRoute(
      page: SplashRoute.page,
      path: '/',
      initial: true,
    ),
    AutoRoute(
      page: LoginRoute.page,
      path: '/login',
    ),
    AutoRoute(
      page: HomeRoute.page,
      path: '/home',
    ),
    CustomRoute(
      page: SearchProductRoute.page,
      path: '/search-product',
      transitionsBuilder: TransitionsBuilders.noTransition,
    ),
    AutoRoute(
      page: ProductDetailRoute.page,
      path: '/product-detail/:productId',
    ),
    AutoRoute(
      page: CartListRoute.page,
      path: '/cart',
    ),
  ];
}
