import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:ur_store/app/features/product/domain/entities/product_entity.dart';
import 'package:ur_store/app/features/product/domain/params/get_product_params.dart';
import 'package:ur_store/app/features/product/domain/usecases/get_products_usecase.dart';

import '../../../../helpers/mock_container.mocks.dart';

void main() {
  late GetProductsUsecase usecase;
  late MockProductRepository mockRepository;

  setUp(() {
    mockRepository = MockProductRepository();
    usecase = GetProductsUsecase(repository: mockRepository);
  });

  final tProducts = [
    const ProductEntity(
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
    )
  ];

  test('should get list of products from repository', () async {
    // arrange
    final params = GetProductParams();
    when(mockRepository.getProducts(any))
        .thenAnswer((_) async => Right(tProducts));

    // act
    final result = await usecase(params);

    // assert
    expect(result, Right(tProducts));
    verify(mockRepository.getProducts(params));
    verifyNoMoreInteractions(mockRepository);
  });
}
