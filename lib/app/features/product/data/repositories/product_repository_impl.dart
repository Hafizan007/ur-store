import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/networking/app_exception.dart';
import '../../../../config/networking/failure.dart';
import '../../../../config/networking/network_info.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/params/get_product_by_category_params.dart';
import '../../domain/params/get_product_detail_params.dart';
import '../../domain/params/get_product_params.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasource/remote/product_remote_datasource.dart';

@LazySingleton(as: ProductRepository)
class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ProductRepositoryImpl(
      {required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts(
      GetProductParams params) async {
    try {
      if (!await networkInfo.isConnected) {
        return const Left(NetworkFailure());
      }

      final result = await remoteDataSource.getProducts(params);
      return Right(result.map((model) => model.toDomain()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.statusCode, e.message));
    } catch (e) {
      return const Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getCategoryProducts(
      GetProductByCategoryParams params) async {
    try {
      if (!await networkInfo.isConnected) {
        return const Left(NetworkFailure());
      }

      final result = await remoteDataSource.getCategoryProducts(params);
      return Right(result.map((model) => model.toDomain()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.statusCode, e.message));
    } catch (e) {
      return const Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, List<CategoryEntity>>> getCategories() async {
    try {
      if (!await networkInfo.isConnected) {
        return const Left(NetworkFailure());
      }

      final result = await remoteDataSource.getCategories();
      return Right(result.map((model) => model.toDomain()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.statusCode, e.message));
    } catch (e) {
      return const Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, ProductEntity>> getProductDetail(
      GetProductDetailParams params) async {
    try {
      if (!await networkInfo.isConnected) {
        return const Left(NetworkFailure());
      }

      final result = await remoteDataSource.getProductDetail(params);
      return Right(result.toDomain());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.statusCode, e.message));
    } catch (e) {
      return const Left(UnknownFailure());
    }
  }
}
