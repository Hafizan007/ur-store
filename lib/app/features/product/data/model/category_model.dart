import 'package:json_annotation/json_annotation.dart';

import '../../../../config/networking/response_mapper.dart';
import '../../domain/entities/category_entity.dart';

part 'category_model.g.dart';

@JsonSerializable()
class CategoryModel implements ResponseMapper<CategoryEntity> {
  final String name;

  CategoryModel({
    required this.name,
  });

  factory CategoryModel.fromJson(String json) => CategoryModel(name: json);

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);

  @override
  CategoryEntity toDomain() {
    return CategoryEntity(
      name: name,
    );
  }

  static List<CategoryModel> fromJsonList(List<dynamic> json) {
    return json.map((e) => CategoryModel.fromJson(e as String)).toList();
  }
}
