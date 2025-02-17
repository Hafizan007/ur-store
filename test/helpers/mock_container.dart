import 'package:ur_store/app/config/env/env.dart';
import 'package:ur_store/app/config/networking/network_info.dart';
import 'package:ur_store/app/features/auth/data/datasource/local/auth_local_datasource.dart';
import 'package:ur_store/app/features/auth/data/datasource/remote/auth_remote_datasource.dart';
import 'package:ur_store/app/features/auth/domain/repositories/auth_repositoriy.dart';
import 'package:ur_store/app/features/auth/domain/usecases/login_with_username_usecase.dart';
import 'package:ur_store/app/features/cart/data/datasource/local/cart_local_datasource.dart';
import 'package:ur_store/app/features/cart/domain/repositories/cart_repository.dart';
import 'package:ur_store/app/features/product/data/datasource/remote/product_remote_datasource.dart';
import 'package:ur_store/app/features/product/domain/repositories/product_repository.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  //APP RELATED
  NetworkInfo,
  AppEnvironment,

  /// AUTH RELATED
  AuthLocalDataSource,
  AuthRemoteDataSource,
  AuthRepository,
  LoginWithUsernameUseCase,

  //PRODUCT RELATED
  ProductRemoteDataSource,
  ProductRepository,

  //CART RELATED
  CartLocalDataSource,
  CartRepository,
])
void main() {}
