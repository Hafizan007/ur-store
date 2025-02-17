import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/networking/failure.dart';
import '../../../../config/usecase/usecase.dart';
import '../entities/cart_entity.dart';
import '../repositories/cart_repository.dart';

@lazySingleton
class GetCartUseCase implements UseCase<List<CartEntity>, NoParams> {
  final CartRepository repository;

  GetCartUseCase(this.repository);

  @override
  Future<Either<Failure, List<CartEntity>>> call(NoParams params) {
    return repository.getCart();
  }
}
