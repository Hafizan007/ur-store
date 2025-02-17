import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:ur_store/app/config/usecase/usecase.dart';
import 'package:ur_store/app/features/product/domain/entities/category_entity.dart';
import 'package:ur_store/app/features/product/domain/usecases/get_categories_usecase.dart';

import '../../../../helpers/mock_container.mocks.dart';

void main() {
  late GetCategoriesUsecase usecase;
  late MockProductRepository mockRepository;

  setUp(() {
    mockRepository = MockProductRepository();
    usecase = GetCategoriesUsecase(repository: mockRepository);
  });

  final tCategories = [
    const CategoryEntity(
      name: 'Test Category',
    )
  ];

  test('should get categories from repository', () async {
    // arrange
    when(mockRepository.getCategories())
        .thenAnswer((_) async => Right(tCategories));

    // act
    final result = await usecase(NoParams());

    // assert
    expect(result, Right(tCategories));
    verify(mockRepository.getCategories());
    verifyNoMoreInteractions(mockRepository);
  });
}
