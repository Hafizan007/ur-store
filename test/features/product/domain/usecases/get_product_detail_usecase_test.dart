import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:ur_store/app/features/product/domain/entities/product_entity.dart';
import 'package:ur_store/app/features/product/domain/params/get_product_detail_params.dart';
import 'package:ur_store/app/features/product/domain/usecases/get_product_detail_usecase.dart';

import '../../../../helpers/mock_container.mocks.dart';

void main() {
  late GetProductDetailUseCase usecase;
  late MockProductRepository mockRepository;

  setUp(() {
    mockRepository = MockProductRepository();
    usecase = GetProductDetailUseCase(mockRepository);
  });

  const tProduct = ProductEntity(
    id: 1,
    title: 'Test Product',
    price: 100,
    description: 'Test Description',
    category: 'Test Category',
    image: 'test.jpg',
    rating: RatingEntity(
      rate: 4.5,
      count: 10,
    ),
  );

  test('should get product detail from repository', () async {
    // arrange
    final params = GetProductDetailParams(id: 1);
    when(mockRepository.getProductDetail(any))
        .thenAnswer((_) async => const Right(tProduct));

    // act
    final result = await usecase(params);

    // assert
    expect(result, const Right(tProduct));
    verify(mockRepository.getProductDetail(params));
    verifyNoMoreInteractions(mockRepository);
  });
}
