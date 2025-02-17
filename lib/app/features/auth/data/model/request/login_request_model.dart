import '../../../domain/params/login_by_username_params.dart';

class LoginRequestModel {
  final String username;
  final String password;

  LoginRequestModel({
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
    };
  }

  factory LoginRequestModel.fromDomain(LoginByUsernameParams params) {
    return LoginRequestModel(
      username: params.username,
      password: params.password,
    );
  }
}
