import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/usecase/usecase.dart';
import '../../../auth/domain/usecases/check_auth_status_usecase.dart';

part 'splash_state.dart';

@injectable
class SplashCubit extends Cubit<SplashState> {
  final CheckAuthStatusUsecase checkAuthStatusUsecase;

  SplashCubit({
    required this.checkAuthStatusUsecase,
  }) : super(SplashInitial());

  Future<void> checkAuthentification() async {
    emit(SplashLoading());

    final result = await checkAuthStatusUsecase(NoParams());
    result.fold(
      (failure) => emit(SplashError(failure.message)),
      (isAuthenticated) {
        if (isAuthenticated) {
          emit(SplashAuthenticated());
        } else {
          emit(SplashUnauthenticated());
        }
      },
    );
  }
}
