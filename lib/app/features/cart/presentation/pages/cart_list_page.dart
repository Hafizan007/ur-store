import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants/typograph.dart';
import '../../../../utils/widgets/button/custom_fill_button.dart';
import '../cubit/cart_cubit.dart';
import '../widgets/cart_item_widget.dart';

@RoutePage()
class CartListPage extends StatelessWidget {
  const CartListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
      ),
      body: BlocBuilder<CartCubit, CartState>(
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
            if (state.items.isEmpty) {
              return const Center(child: Text('Cart is empty'));
            }

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: state.items.length,
                    itemBuilder: (context, index) {
                      final item = state.items[index];
                      return CartItemWidget(item: item);
                    },
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total ${state.totalQuantity} items: ',
                              style: Typograph.label16m,
                            ),
                            Text(
                              'USD ${state.total.toStringAsFixed(2)}',
                              style: Typograph.subtitle16m,
                            ),
                          ],
                        ),
                      ),
                      CustomFillButton(
                          text: 'Proceed to Checkout', onPressed: () {})
                    ],
                  ),
                ),
              ],
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
