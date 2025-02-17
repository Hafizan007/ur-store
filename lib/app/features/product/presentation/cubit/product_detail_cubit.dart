import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/product_entity.dart';
import '../../domain/params/get_product_detail_params.dart';
import '../../domain/usecases/get_product_detail_usecase.dart';

part 'product_detail_state.dart';

@injectable
class ProductDetailCubit extends Cubit<ProductDetailState> {
  final GetProductDetailUseCase getProductDetailUseCase;

  ProductDetailCubit(this.getProductDetailUseCase)
      : super(ProductDetailInitial());

  Future<void> getProductDetail(int id) async {
    emit(ProductDetailLoading());

    final result = await getProductDetailUseCase(
      GetProductDetailParams(id: id),
    );

    result.fold(
      (failure) => emit(ProductDetailError(failure.message)),
      (data) => emit(ProductDetailLoaded(data)),
    );
  }
}
