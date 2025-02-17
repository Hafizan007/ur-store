import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/networking/failure.dart';
import '../../../../config/usecase/usecase.dart';
import '../entities/product_entity.dart';
import '../params/get_product_by_category_params.dart';
import '../repositories/product_repository.dart';

@lazySingleton
class GetCategoryProductsUsecase
    implements UseCase<List<ProductEntity>, GetProductByCategoryParams> {
  final ProductRepository repository;

  GetCategoryProductsUsecase({
    required this.repository,
  });

  @override
  Future<Either<Failure, List<ProductEntity>>> call(
      GetProductByCategoryParams params) async {
    return repository.getCategoryProducts(params);
  }
}
