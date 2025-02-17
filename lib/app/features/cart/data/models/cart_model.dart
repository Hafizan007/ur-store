import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../config/networking/response_mapper.dart';
import '../../domain/entities/cart_entity.dart';

part 'cart_model.freezed.dart';
part 'cart_model.g.dart';

@freezed
class CartModel with _$CartModel implements ResponseMapper<CartEntity> {
  const CartModel._();

  const factory CartModel({
    required int id,
    required int productId,
    required String title,
    required double price,
    required String image,
    required int quantity,
  }) = _CartModel;

  factory CartModel.fromJson(Map<String, dynamic> json) =>
      _$CartModelFromJson(json);

  @override
  CartEntity toDomain() {
    return CartEntity(
      id: id,
      productId: productId,
      title: title,
      price: price,
      image: image,
      quantity: quantity,
    );
  }
}
