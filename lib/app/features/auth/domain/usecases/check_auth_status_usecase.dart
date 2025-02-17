import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/networking/failure.dart';
import '../../../../config/usecase/usecase.dart';
import '../repositories/auth_repositoriy.dart';

@lazySingleton
class CheckAuthStatusUsecase implements UseCase<bool, NoParams> {
  final AuthRepository repository;

  CheckAuthStatusUsecase({
    required this.repository,
  });

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return repository.checkAuthStatus();
  }
}
