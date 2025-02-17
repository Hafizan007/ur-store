import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mockito/mockito.dart';
import 'package:ur_store/app/config/networking/app_exception.dart';
import 'package:ur_store/app/config/networking/failure.dart';
import 'package:ur_store/app/features/product/data/model/category_model.dart';
import 'package:ur_store/app/features/product/data/model/product_model.dart';
import 'package:ur_store/app/features/product/data/model/rating_model.dart';
import 'package:ur_store/app/features/product/data/repositories/product_repository_impl.dart';
import 'package:ur_store/app/features/product/domain/params/get_product_by_category_params.dart';
import 'package:ur_store/app/features/product/domain/params/get_product_detail_params.dart';
import 'package:ur_store/app/features/product/domain/params/get_product_params.dart';
import 'package:ur_store/app/features/product/domain/repositories/product_repository.dart';

import '../../../../helpers/mock_container.mocks.dart';

void main() {
  late ProductRepository repository;
  late MockNetworkInfo mockNetworkInfo;
  late MockProductRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockProductRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = ProductRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  group('getProducts', () {
    final params = GetProductParams();
    final tProducts = [
      ProductModel(
        id: 1,
        title: 'Test Product',
        price: 10.0,
        description: 'Test Description',
        category: 'Test Category',
        image: 'test.jpg',
        rating: const RatingModel(
          rate: 4.5,
          count: 10,
        ),
      ),
    ];

    test('should return list of products when call is successful', () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getProducts(any))
          .thenAnswer((_) async => tProducts);

      final result = await repository.getProducts(params);
      final expected = Right(tProducts.map((e) => e.toDomain()).toList());

      final equality = const DeepCollectionEquality().equals(
        expected.fold((l) => l, (r) => r),
        result.fold((l) => l, (r) => r),
      );

      expect(equality, isTrue);
      verify(mockRemoteDataSource.getProducts(params));
    });

    test('should return ServerFailure when call is unsuccessful', () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getProducts(any)).thenThrow(ServerException());

      final result = await repository.getProducts(params);

      expect(result, const Left(ServerFailure(500, 'Server Error')));
      verify(mockRemoteDataSource.getProducts(params));
    });

    test('should return NetworkFailure when there is no internet connection',
        () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);

      final result = await repository.getProducts(params);

      expect(result, const Left(NetworkFailure()));
      verifyNever(mockRemoteDataSource.getProducts(params));
    });
  });

  group('getProductDetail', () {
    final params = GetProductDetailParams(id: 1);
    final tProduct = ProductModel(
      id: 1,
      title: 'Test Product',
      price: 10.0,
      description: 'Test Description',
      category: 'Test Category',
      image: 'test.jpg',
      rating: const RatingModel(
        rate: 4.5,
        count: 10,
      ),
    );

    test('should return product detail when call is successful', () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getProductDetail(any))
          .thenAnswer((_) async => tProduct);

      final result = await repository.getProductDetail(params);

      expect(result, Right(tProduct.toDomain()));
      verify(mockRemoteDataSource.getProductDetail(params));
    });

    test('should return ServerFailure when call is unsuccessful', () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getProductDetail(any))
          .thenThrow(ServerException());

      final result = await repository.getProductDetail(params);

      expect(result, const Left(ServerFailure(500, 'Server Error')));
      verify(mockRemoteDataSource.getProductDetail(params));
    });

    test('should return NetworkFailure when there is no internet connection',
        () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);

      final result = await repository.getProductDetail(params);

      expect(result, const Left(NetworkFailure()));
      verifyNever(mockRemoteDataSource.getProductDetail(params));
    });
  });

  group('getCategories', () {
    final tCategories = [
      CategoryModel(name: 'Category 1'),
      CategoryModel(name: 'Category 2'),
    ];

    test('should return list of categories when call is successful', () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getCategories())
          .thenAnswer((_) async => tCategories);

      final result = await repository.getCategories();

      final expected = Right(tCategories.map((e) => e.toDomain()).toList());

      final equality = const DeepCollectionEquality().equals(
        expected.fold((l) => l, (r) => r),
        result.fold((l) => l, (r) => r),
      );

      expect(equality, isTrue);

      verify(mockRemoteDataSource.getCategories());
    });

    test('should return ServerFailure when call is unsuccessful', () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getCategories()).thenThrow(ServerException());

      final result = await repository.getCategories();

      expect(result, const Left(ServerFailure(500, 'Server Error')));
      verify(mockRemoteDataSource.getCategories());
    });

    test('should return NetworkFailure when there is no internet connection',
        () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);

      final result = await repository.getCategories();

      expect(result, const Left(NetworkFailure()));
      verifyNever(mockRemoteDataSource.getCategories());
    });
  });

  group('getCategoryProducts', () {
    final params = GetProductByCategoryParams(category: 'electronics');
    final tProducts = [
      ProductModel(
        id: 1,
        title: 'Test Product',
        price: 10.0,
        description: 'Test Description',
        category: 'electronics',
        image: 'test.jpg',
        rating: const RatingModel(
          rate: 4.5,
          count: 10,
        ),
      ),
    ];

    test('should return list of category products when call is successful',
        () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getCategoryProducts(any))
          .thenAnswer((_) async => tProducts);

      final result = await repository.getCategoryProducts(params);
      final expected = Right(tProducts.map((e) => e.toDomain()).toList());

      final equality = const DeepCollectionEquality().equals(
        expected.fold((l) => l, (r) => r),
        result.fold((l) => l, (r) => r),
      );

      expect(equality, isTrue);

      verify(mockRemoteDataSource.getCategoryProducts(params));
    });

    test('should return ServerFailure when call is unsuccessful', () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getCategoryProducts(any))
          .thenThrow(ServerException());

      final result = await repository.getCategoryProducts(params);

      expect(result, const Left(ServerFailure(500, 'Server Error')));
      verify(mockRemoteDataSource.getCategoryProducts(params));
    });

    test('should return NetworkFailure when there is no internet connection',
        () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);

      final result = await repository.getCategoryProducts(params);

      expect(result, const Left(NetworkFailure()));
      verifyNever(mockRemoteDataSource.getCategoryProducts(params));
    });
  });
}
