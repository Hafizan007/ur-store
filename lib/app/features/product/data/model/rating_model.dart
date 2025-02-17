import 'package:json_annotation/json_annotation.dart';

import '../../../../config/networking/response_mapper.dart';
import '../../domain/entities/product_entity.dart';

part 'rating_model.g.dart';

@JsonSerializable()
class RatingModel implements ResponseMapper<RatingEntity> {
  final double rate;
  final int count;

  const RatingModel({
    required this.rate,
    required this.count,
  });

  factory RatingModel.fromJson(Map<String, dynamic> json) =>
      _$RatingModelFromJson(json);

  Map<String, dynamic> toJson() => _$RatingModelToJson(this);

  @override
  RatingEntity toDomain() {
    return RatingEntity(
      rate: rate,
      count: count,
    );
  }
}
