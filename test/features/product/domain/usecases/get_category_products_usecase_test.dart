import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:ur_store/app/features/product/domain/entities/product_entity.dart';
import 'package:ur_store/app/features/product/domain/params/get_product_by_category_params.dart';
import 'package:ur_store/app/features/product/domain/usecases/get_category_products_usecase.dart';

import '../../../../helpers/mock_container.mocks.dart';

void main() {
  late GetCategoryProductsUsecase usecase;
  late MockProductRepository mockRepository;

  setUp(() {
    mockRepository = MockProductRepository();
    usecase = GetCategoryProductsUsecase(repository: mockRepository);
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

  test('should get category products from repository', () async {
    // arrange
    final params = GetProductByCategoryParams(category: 'Test Category');
    when(mockRepository.getCategoryProducts(any))
        .thenAnswer((_) async => Right(tProducts));

    // act
    final result = await usecase(params);

    // assert
    expect(result, Right(tProducts));
    verify(mockRepository.getCategoryProducts(params));
    verifyNoMoreInteractions(mockRepository);
  });
}
