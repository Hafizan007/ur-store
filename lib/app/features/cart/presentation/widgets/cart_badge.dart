import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/router/app_router.gr.dart';
import '../../../../config/themes/app_color.dart';
import '../cubit/cart_cubit.dart';

class CartItem extends StatelessWidget {
  const CartItem({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        if (state.status == CartStateStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.status == CartStateStatus.failure) {
          return Center(
            child: Text(state.errorMessage!),
          );
        } else if (state.status == CartStateStatus.success) {
          final totalQuantity =
              state.totalQuantity > 99 ? '99+' : state.totalQuantity.toString();
          return InkWell(
            onTap: () {
              context.pushRoute(const CartListRoute());
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Icon(
                    Icons.shopping_cart_outlined,
                    color: Colors.black,
                    size: 24,
                  ),
                  if (state.status == CartStateStatus.success &&
                      state.items.isNotEmpty)
                    Positioned(
                      top: 10,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: AppColor.primaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: Text(
                          totalQuantity,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        }

        return const SizedBox();
      },
    );
  }
}
