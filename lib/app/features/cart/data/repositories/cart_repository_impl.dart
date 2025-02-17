import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/networking/app_exception.dart';
import '../../../../config/networking/failure.dart';
import '../../domain/entities/cart_entity.dart';
import '../../domain/params/remove_cart_params.dart';
import '../../domain/repositories/cart_repository.dart';
import '../datasource/local/cart_local_datasource.dart';
import '../models/cart_model.dart';

@LazySingleton(as: CartRepository)
class CartRepositoryImpl implements CartRepository {
  final CartLocalDataSource localDataSource;

  CartRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<CartEntity>>> getCart() async {
    try {
      final result = await localDataSource.getCart();
      return Right(result.map((model) => model.toDomain()).toList());
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, CartEntity>> addToCart(CartEntity cart) async {
    try {
      final cartModel = CartModel(
        id: cart.id,
        productId: cart.productId,
        title: cart.title,
        price: cart.price,
        image: cart.image,
        quantity: cart.quantity,
      );
      final result = await localDataSource.addToCart(cartModel);
      return Right(result.toDomain());
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> updateCart(CartEntity cart) async {
    try {
      final cartModel = CartModel(
        id: cart.id,
        productId: cart.productId,
        title: cart.title,
        price: cart.price,
        image: cart.image,
        quantity: cart.quantity,
      );
      await localDataSource.updateCart(cartModel);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> removeFromCart(RemoveCartParams params) async {
    try {
      await localDataSource.removeFromCart(params.id);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }
}
