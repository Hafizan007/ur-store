import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/networking/failure.dart';
import '../../../../config/usecase/usecase.dart';
import '../params/remove_cart_params.dart';
import '../repositories/cart_repository.dart';

@lazySingleton
class RemoveCartUsecase implements UseCase<void, RemoveCartParams> {
  final CartRepository repository;

  RemoveCartUsecase(this.repository);

  @override
  Future<Either<Failure, void>> call(RemoveCartParams params) {
    return repository.removeFromCart(params);
  }
}
