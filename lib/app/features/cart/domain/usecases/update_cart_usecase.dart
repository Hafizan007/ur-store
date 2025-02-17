import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/networking/failure.dart';
import '../../../../config/usecase/usecase.dart';
import '../entities/cart_entity.dart';
import '../repositories/cart_repository.dart';

@lazySingleton
class UpdateCartUsecase implements UseCase<void, CartEntity> {
  final CartRepository repository;

  UpdateCartUsecase(this.repository);

  @override
  Future<Either<Failure, void>> call(CartEntity params) {
    return repository.updateCart(params);
  }
}
