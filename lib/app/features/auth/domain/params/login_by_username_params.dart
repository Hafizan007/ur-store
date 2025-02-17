import 'package:equatable/equatable.dart';

class LoginByUsernameParams extends Equatable {
  final String username;
  final String password;

  const LoginByUsernameParams({
    required this.username,
    required this.password,
  });

  @override
  List<Object?> get props => [username, password];
}
