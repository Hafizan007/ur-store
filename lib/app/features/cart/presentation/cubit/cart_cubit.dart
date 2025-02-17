import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/usecase/usecase.dart';
import '../../../product/domain/entities/product_entity.dart';
import '../../domain/entities/cart_entity.dart';
import '../../domain/params/remove_cart_params.dart';
import '../../domain/usecases/add_cart_usecase.dart';
import '../../domain/usecases/get_cart_usecase.dart';
import '../../domain/usecases/remove_cart_usecase.dart';
import '../../domain/usecases/update_cart_usecase.dart';

part 'cart_state.dart';

@injectable
class CartCubit extends Cubit<CartState> {
  final GetCartUseCase getCartUseCase;
  final AddCartUseCase addCartUseCase;
  final UpdateCartUsecase updateCartUsecase;
  final RemoveCartUsecase deleteCartUsecase;

  CartCubit({
    required this.getCartUseCase,
    required this.addCartUseCase,
    required this.updateCartUsecase,
    required this.deleteCartUsecase,
  }) : super(const CartState());

  Future<void> getCart() async {
    emit(state.copyWith(status: CartStateStatus.loading));

    final result = await getCartUseCase(NoParams());

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: CartStateStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (items) {
        final total = items.fold<double>(
          0,
          (sum, item) => sum + (item.price * item.quantity),
        );

        final totalQuantity = items.fold<int>(
          0,
          (sum, item) => sum + item.quantity,
        );

        emit(
          state.copyWith(
            status: CartStateStatus.success,
            items: items,
            total: total,
            totalQuantity: totalQuantity,
          ),
        );
      },
    );
  }

  Future<void> addToCart(ProductEntity product) async {
    final cartEntity = CartEntity(
      id: product.id,
      productId: product.id,
      title: product.title,
      price: product.price,
      image: product.image,
      quantity: 1,
    );
    final result = await addCartUseCase(cartEntity);

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: CartStateStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (_) => getCart(),
    );
  }

  Future<void> updateQuantity(CartEntity item, int newQuantity) async {
    if (state.status == CartStateStatus.success) {
      final updatedItems = state.items.map((cartItem) {
        if (cartItem.id == item.id) {
          final newItem = cartItem.copyWith(quantity: newQuantity);
          updateCartUsecase(newItem);
          return newItem;
        }
        return cartItem;
      }).toList();

      final total = updatedItems.fold<double>(
        0,
        (sum, item) => sum + (item.price * item.quantity),
      );

      final totalQuantity = updatedItems.fold<int>(
        0,
        (sum, item) => sum + item.quantity,
      );

      emit(
        state.copyWith(
          items: updatedItems,
          total: total,
          totalQuantity: totalQuantity,
        ),
      );
    }
  }

  Future<void> removeItem(CartEntity item) async {
    final result = await deleteCartUsecase(RemoveCartParams(id: item.id));

    result.fold(
        (failure) => emit(
              state.copyWith(
                status: CartStateStatus.failure,
                errorMessage: failure.message,
              ),
            ), (_) {
      final updatedItems =
          state.items.where((cartItem) => cartItem.id != item.id).toList();

      final total = updatedItems.fold<double>(
        0,
        (sum, item) => sum + (item.price * item.quantity),
      );

      final totalQuantity = updatedItems.fold<int>(
        0,
        (sum, item) => sum + item.quantity,
      );

      emit(
        state.copyWith(
          items: updatedItems,
          total: total,
          totalQuantity: totalQuantity,
        ),
      );
    });
  }
}
