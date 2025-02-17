import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/injection/injection.dart';
import '../cubit/product_cubit.dart';
import '../widgets/product_card.dart';
import '../widgets/search_appbar.dart';

@RoutePage()
class SearchProductPage extends StatefulWidget {
  const SearchProductPage({
    super.key,
  });

  @override
  State<SearchProductPage> createState() => _SearchProductPageState();
}

class _SearchProductPageState extends State<SearchProductPage> {
  final searchController = TextEditingController();
  final productsCubit = getIt<ProductCubit>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => productsCubit,
      child: Scaffold(
        body: Column(
          children: [
            SearchAppBar(
              title: 'Search',
              searchController: searchController,
              onSubmitted: (value) {
                productsCubit.getProducts(search: value, limit: 20);
              },
            ),
            Expanded(
              child: BlocBuilder<ProductCubit, ProductState>(
                builder: (context, state) {
                  if (state is ProductLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is ProductError) {
                    return Center(child: Text(state.message));
                  }

                  if (state is ProductLoaded) {
                    return GridView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(16),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.6,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                      ),
                      itemCount: state.products.length,
                      itemBuilder: (context, index) {
                        final product = state.products[index];
                        return ProductCard(
                          product: product,
                          onTap: (product) {},
                        );
                      },
                    );
                  }

                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
