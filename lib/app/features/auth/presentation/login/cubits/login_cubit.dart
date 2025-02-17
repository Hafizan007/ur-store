import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/entities/login_entity.dart';
import '../../../domain/params/login_by_username_params.dart';
import '../../../domain/usecases/login_with_username_usecase.dart';

part 'login_state.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  final LoginWithUsernameUseCase loginUseCase;

  LoginCubit(this.loginUseCase) : super(LoginInitial());

  void login(String username, String password) async {
    emit(LoginLoading());

    final result = await loginUseCase(
      LoginByUsernameParams(username: username, password: password),
    );
    result.fold(
      (failure) => emit(LoginError(failure.message)),
      (user) => emit(LoginSuccess(user)),
    );
  }
}
