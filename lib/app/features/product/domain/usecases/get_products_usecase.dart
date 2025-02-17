import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/networking/failure.dart';
import '../../../../config/usecase/usecase.dart';
import '../entities/product_entity.dart';
import '../params/get_product_params.dart';
import '../repositories/product_repository.dart';

@lazySingleton
class GetProductsUsecase
    implements UseCase<List<ProductEntity>, GetProductParams> {
  final ProductRepository repository;

  GetProductsUsecase({required this.repository});

  @override
  Future<Either<Failure, List<ProductEntity>>> call(
      GetProductParams params) async {
    return repository.getProducts(params);
  }
}
