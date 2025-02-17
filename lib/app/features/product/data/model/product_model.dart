import 'package:json_annotation/json_annotation.dart';

import '../../../../config/networking/response_mapper.dart';
import '../../domain/entities/product_entity.dart';
import 'rating_model.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel implements ResponseMapper<ProductEntity> {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final RatingModel rating;

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);

  @override
  ProductEntity toDomain() {
    return ProductEntity(
      id: id,
      title: title,
      price: price,
      description: description,
      category: category,
      image: image,
      rating: rating.toDomain(),
    );
  }
}
