part of 'product_cubit.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object?> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {
  final bool isFirstFetch;

  const ProductLoading({this.isFirstFetch = true});

  @override
  List<Object?> get props => [isFirstFetch];
}

class ProductLoaded extends ProductState {
  final List<ProductEntity> products;

  const ProductLoaded({
    required this.products,
  });

  @override
  List<Object?> get props => [
        products,
      ];

  ProductLoaded copyWith({
    List<ProductEntity>? products,
  }) {
    return ProductLoaded(
      products: products ?? this.products,
    );
  }
}

class ProductError extends ProductState {
  final String message;

  const ProductError(this.message);

  @override
  List<Object?> get props => [message];
}
