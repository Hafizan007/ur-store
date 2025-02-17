import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/networking/failure.dart';
import '../../../../config/usecase/usecase.dart';
import '../entities/category_entity.dart';
import '../repositories/product_repository.dart';

@lazySingleton
class GetCategoriesUsecase implements UseCase<List<CategoryEntity>, NoParams> {
  final ProductRepository repository;

  GetCategoriesUsecase({required this.repository});

  @override
  Future<Either<Failure, List<CategoryEntity>>> call(NoParams params) async {
    return repository.getCategories();
  }
}
