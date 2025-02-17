import 'package:dartz/dartz.dart';

import '../../../../config/networking/failure.dart';
import '../entities/category_entity.dart';
import '../entities/product_entity.dart';
import '../params/get_product_by_category_params.dart';
import '../params/get_product_detail_params.dart';
import '../params/get_product_params.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<ProductEntity>>> getProducts(
      GetProductParams params);
  Future<Either<Failure, List<CategoryEntity>>> getCategories();
  Future<Either<Failure, List<ProductEntity>>> getCategoryProducts(
      GetProductByCategoryParams params);
  Future<Either<Failure, ProductEntity>> getProductDetail(
      GetProductDetailParams params);
}
