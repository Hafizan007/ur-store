import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mockito/mockito.dart';
import 'package:ur_store/app/config/networking/app_exception.dart';
import 'package:ur_store/app/config/networking/failure.dart';
import 'package:ur_store/app/features/cart/data/models/cart_model.dart';
import 'package:ur_store/app/features/cart/data/repositories/cart_repository_impl.dart';
import 'package:ur_store/app/features/cart/domain/params/remove_cart_params.dart';
import 'package:ur_store/app/features/cart/domain/repositories/cart_repository.dart';

import '../../../../helpers/mock_container.mocks.dart';

void main() {
  late CartRepository repository;
  late MockCartLocalDataSource mockLocalDataSource;

  setUp(() {
    mockLocalDataSource = MockCartLocalDataSource();
    repository = CartRepositoryImpl(
      localDataSource: mockLocalDataSource,
    );
  });

  const tCartModel = CartModel(
    id: 1,
    productId: 1,
    title: 'Test Product',
    price: 10.0,
    image: 'test.jpg',
    quantity: 1,
  );

  group('getCart', () {
    test('should return list of cart items when call is successful', () async {
      when(mockLocalDataSource.getCart()).thenAnswer((_) async => [tCartModel]);

      final result = await repository.getCart();

      final expected = Right([tCartModel.toDomain()]);

      final equality = const DeepCollectionEquality().equals(
        expected.fold((l) => l, (r) => r),
        result.fold((l) => l, (r) => r),
      );

      expect(equality, isTrue);

      verify(mockLocalDataSource.getCart());
      verifyNoMoreInteractions(mockLocalDataSource);
    });

    test('should return CacheFailure when call is unsuccessful', () async {
      when(mockLocalDataSource.getCart()).thenThrow(CacheException());

      final result = await repository.getCart();

      expect(result, const Left(CacheFailure('Cache Error')));
      verify(mockLocalDataSource.getCart());
      verifyNoMoreInteractions(mockLocalDataSource);
    });
  });

  group('addToCart', () {
    test('should return cart item when call is successful', () async {
      when(mockLocalDataSource.addToCart(any))
          .thenAnswer((_) async => tCartModel);

      final result = await repository.addToCart(tCartModel.toDomain());

      expect(result, Right(tCartModel.toDomain()));
      verify(mockLocalDataSource.addToCart(any));
      verifyNoMoreInteractions(mockLocalDataSource);
    });

    test('should return CacheFailure when call is unsuccessful', () async {
      when(mockLocalDataSource.addToCart(any)).thenThrow(CacheException());

      final result = await repository.addToCart(tCartModel.toDomain());

      expect(result, const Left(CacheFailure('Cache Error')));
      verify(mockLocalDataSource.addToCart(any));
      verifyNoMoreInteractions(mockLocalDataSource);
    });
  });

  group('updateCart', () {
    test('should return void when call is successful', () async {
      when(mockLocalDataSource.updateCart(any)).thenAnswer((_) async => {});

      final result = await repository.updateCart(tCartModel.toDomain());

      expect(result, const Right(null));
      verify(mockLocalDataSource.updateCart(any));
      verifyNoMoreInteractions(mockLocalDataSource);
    });

    test('should return CacheFailure when call is unsuccessful', () async {
      when(mockLocalDataSource.updateCart(any)).thenThrow(CacheException());

      final result = await repository.updateCart(tCartModel.toDomain());

      expect(result, const Left(CacheFailure('Cache Error')));
      verify(mockLocalDataSource.updateCart(any));
      verifyNoMoreInteractions(mockLocalDataSource);
    });
  });

  group('removeFromCart', () {
    final params = RemoveCartParams(id: 1);

    test('should return void when call is successful', () async {
      when(mockLocalDataSource.removeFromCart(any)).thenAnswer((_) async => {});

      final result = await repository.removeFromCart(params);

      expect(result, const Right(null));
      verify(mockLocalDataSource.removeFromCart(params.id));
      verifyNoMoreInteractions(mockLocalDataSource);
    });

    test('should return CacheFailure when call is unsuccessful', () async {
      when(mockLocalDataSource.removeFromCart(any)).thenThrow(CacheException());

      final result = await repository.removeFromCart(params);

      expect(result, const Left(CacheFailure('Cache Error')));
      verify(mockLocalDataSource.removeFromCart(params.id));
      verifyNoMoreInteractions(mockLocalDataSource);
    });
  });
}
