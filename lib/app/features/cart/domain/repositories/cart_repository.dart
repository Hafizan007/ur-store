import 'package:dartz/dartz.dart';

import '../../../../config/networking/failure.dart';
import '../entities/cart_entity.dart';
import '../params/remove_cart_params.dart';

abstract class CartRepository {
  Future<Either<Failure, List<CartEntity>>> getCart();
  Future<Either<Failure, CartEntity>> addToCart(CartEntity cart);
  Future<Either<Failure, void>> updateCart(CartEntity cart);
  Future<Either<Failure, void>> removeFromCart(RemoveCartParams id);
}
