import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../../config/networking/app_endpoint.dart';
import '../../../../../config/networking/app_exception.dart';
import '../../../../../config/networking/app_network.dart';
import '../../../../../constants/error_constant.dart';
import '../../../domain/params/get_product_by_category_params.dart';
import '../../../domain/params/get_product_detail_params.dart';
import '../../../domain/params/get_product_params.dart';
import '../../model/category_model.dart';
import '../../model/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts(GetProductParams params);
  Future<List<CategoryModel>> getCategories();
  Future<List<ProductModel>> getCategoryProducts(
      GetProductByCategoryParams params);
  Future<ProductModel> getProductDetail(GetProductDetailParams params);
}

@LazySingleton(as: ProductRemoteDataSource)
class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final Dio dio;

  ProductRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<ProductModel>> getProducts(GetProductParams params) async {
    try {
      final queryParams = {
        if (params.limit != null) 'limit': params.limit,
        if (params.search != null) 'search': params.search,
      };

      final response = await dio.get(
        "${AppNetwork().baseUrl}${AppEndPoint.products}",
        queryParameters: queryParams,
      );

      return (response.data as List)
          .map((item) => ProductModel.fromJson(item))
          .toList();
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        final message = e.response?.data['error'] ?? ErrorConstant.unauthorized;
        throw ServerException(
          message: message,
          statusCode: e.response?.statusCode,
        );
      } else {
        throw ServerException(
          message: e.message ?? ErrorConstant.unauthorized,
          statusCode: e.response?.statusCode,
          stackTrace: e.stackTrace,
        );
      }
    }
  }

  @override
  Future<List<ProductModel>> getCategoryProducts(
      GetProductByCategoryParams params) async {
    try {
      final queryParams = {
        if (params.limit != null) 'limit': params.limit,
        if (params.search != null) 'search': params.search,
      };

      final response = await dio.get(
        "${AppNetwork().baseUrl}${AppEndPoint.products}/category/${params.category}",
        queryParameters: queryParams,
      );

      return (response.data as List)
          .map((item) => ProductModel.fromJson(item))
          .toList();
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        final message = e.response?.data['error'] ?? ErrorConstant.unauthorized;
        throw ServerException(
          message: message,
          statusCode: e.response?.statusCode,
        );
      } else {
        throw ServerException(
          message: e.message ?? ErrorConstant.unauthorized,
          statusCode: e.response?.statusCode,
          stackTrace: e.stackTrace,
        );
      }
    }
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    try {
      final response = await dio.get(
        "${AppNetwork().baseUrl}${AppEndPoint.categories}",
      );

      return CategoryModel.fromJsonList(response.data as List);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        final message = e.response?.data['error'] ?? ErrorConstant.unauthorized;
        throw ServerException(
          message: message,
          statusCode: e.response?.statusCode,
        );
      } else {
        throw ServerException(
          message: e.message ?? ErrorConstant.unauthorized,
          statusCode: e.response?.statusCode,
          stackTrace: e.stackTrace,
        );
      }
    }
  }

  @override
  Future<ProductModel> getProductDetail(GetProductDetailParams params) async {
    try {
      final response = await dio.get(
        "${AppNetwork().baseUrl}${AppEndPoint.products}/${params.id}",
      );

      return ProductModel.fromJson(response.data);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        final message = e.response?.data['error'] ?? ErrorConstant.unauthorized;
        throw ServerException(
          message: message,
          statusCode: e.response?.statusCode,
        );
      } else {
        throw ServerException(
          message: e.message ?? ErrorConstant.unauthorized,
          statusCode: e.response?.statusCode,
          stackTrace: e.stackTrace,
        );
      }
    }
  }
}
