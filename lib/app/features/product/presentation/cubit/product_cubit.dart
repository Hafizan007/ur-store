import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/product_entity.dart';
import '../../domain/params/get_product_by_category_params.dart';
import '../../domain/params/get_product_params.dart';
import '../../domain/usecases/get_category_products_usecase.dart';
import '../../domain/usecases/get_products_usecase.dart';

part 'product_state.dart';

@injectable
class ProductCubit extends Cubit<ProductState> {
  final GetProductsUsecase getProductsUsecase;
  final GetCategoryProductsUsecase getCategoryProductsUsecase;

  ProductCubit(this.getProductsUsecase, this.getCategoryProductsUsecase)
      : super(ProductInitial());

  Future<void> getProducts({
    int? limit,
    String? search,
  }) async {
    emit(const ProductLoading());

    final result = await getProductsUsecase(
      GetProductParams(
        limit: limit,
        search: search,
      ),
    );

    result.fold(
      (failure) => emit(ProductError(failure.message)),
      (products) => emit(ProductLoaded(products: products)),
    );
  }

  void refresh() {
    getProducts();
  }

  Future<void> getCategoryProducts({
    int? limit,
    String? search,
    required String category,
  }) async {
    emit(const ProductLoading());

    final result = await getCategoryProductsUsecase(
      GetProductByCategoryParams(
        category: category,
        limit: limit,
        search: search,
      ),
    );

    result.fold(
      (failure) => emit(ProductError(failure.message)),
      (products) => emit(ProductLoaded(products: products)),
    );
  }
}
