import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/networking/failure.dart';
import '../../../../config/usecase/usecase.dart';
import '../entities/login_entity.dart';
import '../params/login_by_username_params.dart';
import '../repositories/auth_repositoriy.dart';

@lazySingleton
class LoginWithUsernameUseCase
    implements UseCase<LoginEntity, LoginByUsernameParams> {
  final AuthRepository repository;

  LoginWithUsernameUseCase(this.repository);

  @override
  Future<Either<Failure, LoginEntity>> call(
      LoginByUsernameParams params) async {
    return repository.loginByUsername(params);
  }
}
