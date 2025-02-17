import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/injection/injection.dart';
import '../../../../config/themes/app_color.dart';
import '../../../../utils/widgets/button/custom_fill_button.dart';
import '../../../cart/presentation/cubit/cart_cubit.dart';
import '../../../cart/presentation/widgets/cart_badge.dart';
import '../cubit/product_detail_cubit.dart';

@RoutePage()
class ProductDetailPage extends StatefulWidget {
  final int productId;

  const ProductDetailPage({
    super.key,
    required this.productId,
  });

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final productDetailCubit = getIt<ProductDetailCubit>();

  @override
  void initState() {
    super.initState();
    productDetailCubit.getProductDetail(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => productDetailCubit,
      child: BlocListener<CartCubit, CartState>(
        listener: (context, state) {
          if (state.status == CartStateStatus.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                duration: Duration(milliseconds: 300),
                content: Text('Product added to cart'),
              ),
            );
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Product Detail'),
            actions: const [
              CartItem(),
            ],
          ),
          body: BlocBuilder<ProductDetailCubit, ProductDetailState>(
            builder: (context, state) {
              if (state is ProductDetailLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is ProductDetailError) {
                return Center(child: Text(state.message));
              }

              if (state is ProductDetailLoaded) {
                final product = state.product;
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AspectRatio(
                        aspectRatio: 1,
                        child: Container(
                          width: double.infinity,
                          decoration: const BoxDecoration(color: Colors.white),
                          child: Image.network(
                            product.image,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 16),
                            Text(
                              product.title,
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '\$${product.price}',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                    color: Theme.of(context).primaryColor,
                                  ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              product.description,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: AppColor.amberReviewColor,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '${product.rating.rate} (${product.rating.count} reviews)',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }

              return const SizedBox();
            },
          ),
          bottomNavigationBar:
              BlocBuilder<ProductDetailCubit, ProductDetailState>(
                  builder: (context, state) {
            if (state is ProductDetailLoaded) {
              final product = state.product;
              return CustomFillButton(
                onPressed: () {
                  context.read<CartCubit>().addToCart(product);
                },
                text: 'Add to Cart',
              );
            } else {
              return const SizedBox();
            }
          }),
        ),
      ),
    );
  }
}
