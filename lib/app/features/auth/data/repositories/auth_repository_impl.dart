import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/networking/app_exception.dart';
import '../../../../config/networking/failure.dart';
import '../../../../config/networking/network_info.dart';
import '../../domain/entities/login_entity.dart';
import '../../domain/params/login_by_username_params.dart';
import '../../domain/repositories/auth_repositoriy.dart';
import '../datasource/local/auth_local_datasource.dart';
import '../datasource/remote/auth_remote_datasource.dart';
import '../model/reponse/user_local_model.dart';
import '../model/request/login_request_model.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, LoginEntity>> loginByUsername(
      LoginByUsernameParams params) async {
    try {
      final requestModel = LoginRequestModel.fromDomain(params);

      final user = await remoteDataSource.loginByUsername(
        loginRequest: requestModel,
      );
      localDataSource.storeUserData(UserLocalModel.fromRemote(user));

      return Right(user.toDomain());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.statusCode, e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      return Right(localDataSource.deleleUserData());
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return const Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> checkAuthStatus() async {
    try {
      final isAuth = await localDataSource.checkAuthStatus();
      return Right(isAuth);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return const Left(UnknownFailure());
    }
  }
}
