import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/networking/failure.dart';
import '../../../../config/usecase/usecase.dart';
import '../entities/cart_entity.dart';
import '../repositories/cart_repository.dart';

@lazySingleton
class AddCartUseCase implements UseCase<CartEntity, CartEntity> {
  final CartRepository repository;

  AddCartUseCase(this.repository);

  @override
  Future<Either<Failure, CartEntity>> call(CartEntity params) {
    return repository.addToCart(params);
  }
}
