part of 'login_cubit.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final LoginEntity loginModel;

  const LoginSuccess(this.loginModel);

  @override
  List<Object> get props => [loginModel];
}

class LoginError extends LoginState {
  final String msg;

  const LoginError(this.msg);

  @override
  List<Object> get props => [msg];
}
