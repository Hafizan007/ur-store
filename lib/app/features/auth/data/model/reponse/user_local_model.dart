import 'package:hive/hive.dart';

import '../../../../../config/networking/networking.dart';
import '../../../../../constants/hive_constant.dart';
import '../../../domain/entities/user_entity.dart';
import 'login_response_model.dart';

part 'user_local_model.g.dart';

@HiveType(typeId: HiveEntityCode.userData)
class UserLocalModel implements ResponseMapper<UserEntity> {
  @HiveField(0)
  final String token;

  UserLocalModel({
    required this.token,
  });

  @override
  UserEntity toDomain() {
    return UserEntity(
      token: token,
    );
  }

  factory UserLocalModel.fromRemote(LoginResponseModel userEntity) {
    return UserLocalModel(
      token: userEntity.token,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'token': token,
    };
  }
}
