import 'package:json_annotation/json_annotation.dart';

import '../../../../../config/networking/response_mapper.dart';
import '../../../domain/entities/login_entity.dart';

part 'login_response_model.g.dart';

@JsonSerializable()
class LoginResponseModel implements ResponseMapper<LoginEntity> {
  final String token;

  LoginResponseModel({
    required this.token,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseModelToJson(this);

  @override
  LoginEntity toDomain() {
    return LoginEntity(
      token: token,
    );
  }
}
