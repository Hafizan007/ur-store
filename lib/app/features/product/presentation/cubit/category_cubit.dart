import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/usecase/usecase.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/usecases/get_categories_usecase.dart';

part 'category_state.dart';

@injectable
class CategoryCubit extends Cubit<CategoryState> {
  final GetCategoriesUsecase getCategoriesUsecase;

  CategoryCubit({
    required this.getCategoriesUsecase,
  }) : super(const CategoryState());

  Future<void> getCategories() async {
    emit(state.copyWith(status: CategoryStateStatus.loading));

    final result = await getCategoriesUsecase(NoParams());

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: CategoryStateStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (categories) => emit(
        state.copyWith(
          status: CategoryStateStatus.success,
          categories: categories,
        ),
      ),
    );
  }

  void selectCategory(String? category) {
    emit(state.copyWith(
      selectedCategory: category,
      clearSelectedCategory: category == null,
    ));
  }
}
