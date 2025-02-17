import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/networking/failure.dart';
import '../../../../config/usecase/usecase.dart';
import '../entities/product_entity.dart';
import '../params/get_product_detail_params.dart';
import '../repositories/product_repository.dart';

@lazySingleton
class GetProductDetailUseCase
    implements UseCase<ProductEntity, GetProductDetailParams> {
  final ProductRepository repository;

  GetProductDetailUseCase(this.repository);

  @override
  Future<Either<Failure, ProductEntity>> call(GetProductDetailParams params) {
    return repository.getProductDetail(params);
  }
}
