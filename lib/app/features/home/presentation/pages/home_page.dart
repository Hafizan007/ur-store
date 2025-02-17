import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/injection/injection.dart';
import '../../../../config/router/app_router.gr.dart';
import '../../../auth/presentation/logout/cubit/logout_cubit.dart';
import '../../../cart/presentation/cubit/cart_cubit.dart';
import '../../../product/presentation/cubit/category_cubit.dart';
import '../../../product/presentation/cubit/product_cubit.dart';
import '../../../product/presentation/sections/categories_section.dart';
import '../../../product/presentation/sections/product_section.dart';
import '../../../product/presentation/sections/search_product_section.dart';
import '../widgets/home_appbar.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final productsCubit = getIt<ProductCubit>();
  final categoryCubit = getIt<CategoryCubit>();
  final logoutCubit = getIt<LogoutCubit>();

  @override
  void initState() {
    productsCubit.getProducts(limit: 20);
    categoryCubit.getCategories();
    context.read<CartCubit>().getCart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: productsCubit),
        BlocProvider.value(value: logoutCubit),
        BlocProvider.value(value: categoryCubit),
      ],
      child: BlocListener<LogoutCubit, LogoutState>(
        listener: (context, state) {
          if (state is LogoutSuccess) {
            context.router.replace(const LoginRoute());
          } else if (state is LogoutFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
        },
        child: Scaffold(
          appBar: const HomeAppbar(),
          body: RefreshIndicator(
            onRefresh: () async {
              productsCubit.getProducts(limit: 20);
            },
            child: const SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SearchProductSection(),
                  CategoriesSection(),
                  ProductSection(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
