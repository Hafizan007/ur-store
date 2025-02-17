part of 'cart_cubit.dart';

enum CartStateStatus { initial, loading, success, failure }

class CartState extends Equatable {
  final CartStateStatus status;
  final List<CartEntity> items;
  final String? errorMessage;
  final double total;
  final int totalQuantity;

  const CartState({
    this.status = CartStateStatus.initial,
    this.items = const [],
    this.errorMessage,
    this.total = 0,
    this.totalQuantity = 0,
  });

  CartState copyWith({
    CartStateStatus? status,
    List<CartEntity>? items,
    String? errorMessage,
    double? total,
    int? totalQuantity,
  }) {
    return CartState(
      status: status ?? this.status,
      items: items ?? this.items,
      errorMessage: errorMessage ?? this.errorMessage,
      total: total ?? this.total,
      totalQuantity: totalQuantity ?? this.totalQuantity,
    );
  }

  @override
  List<Object?> get props =>
      [status, items, errorMessage, total, totalQuantity];
}
