import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/themes/app_color.dart';
import '../../../../constants/typograph.dart';
import '../../domain/entities/cart_entity.dart';
import '../cubit/cart_cubit.dart';

class CartItemWidget extends StatelessWidget {
  final CartEntity item;

  const CartItemWidget({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Image.network(
              item.image,
              width: size.width * 0.25,
              height: size.width * 0.25,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.title, style: Typograph.body12r),
                  const SizedBox(height: 8),
                  Text('\$${item.price.toStringAsFixed(2)}'),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.remove,
                        ),
                        color: AppColor.primaryColor,
                        onPressed: item.quantity > 1
                            ? () {
                                if (item.quantity > 1) {
                                  context.read<CartCubit>().updateQuantity(
                                        item,
                                        item.quantity - 1,
                                      );
                                }
                              }
                            : null,
                      ),
                      Text('${item.quantity}'),
                      IconButton(
                        icon: const Icon(Icons.add),
                        color: AppColor.primaryColor,
                        onPressed: () {
                          context.read<CartCubit>().updateQuantity(
                                item,
                                item.quantity + 1,
                              );
                        },
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        color: AppColor.primaryColor,
                        onPressed: () {
                          context.read<CartCubit>().removeItem(item);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
