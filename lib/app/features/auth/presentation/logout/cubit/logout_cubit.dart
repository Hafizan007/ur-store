import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../config/usecase/usecase.dart';
import '../../../domain/usecases/logout_usecase.dart';

part 'logout_state.dart';

@injectable
class LogoutCubit extends Cubit<LogoutState> {
  final LogoutUsecase logoutUseCase;

  LogoutCubit(this.logoutUseCase) : super(LogoutInitial());

  void logout() async {
    emit(LogoutLoading());

    final result = await logoutUseCase(NoParams());
    result.fold(
      (failure) => emit(LogoutFailure(message: failure.message)),
      (_) => emit(LogoutSuccess()),
    );
  }
}
