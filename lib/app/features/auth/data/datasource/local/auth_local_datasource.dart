import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

import '../../../../../config/networking/app_exception.dart';
import '../../../../../constants/hive_constant.dart';
import '../../model/reponse/user_local_model.dart';

abstract class AuthLocalDataSource {
  Future<void> deleleUserData();
  Future<void> storeUserData(UserLocalModel userModelLocal);
  Future<bool> checkAuthStatus();
}

@LazySingleton(as: AuthLocalDataSource)
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  AuthLocalDataSourceImpl();

  @override
  Future<void> deleleUserData() async {
    try {
      final userDataBox = await Hive.openBox(
        HiveBoxName.userDataBox,
      );

      await userDataBox.clear();
    } catch (error) {
      throw CacheException(
        message: error.toString(),
      );
    }
  }

  @override
  Future<void> storeUserData(UserLocalModel userModelLocal) async {
    try {
      final userDataBox = await Hive.openBox(
        HiveBoxName.userDataBox,
      );

      userDataBox.put(HiveBoxName.userDataBox, userModelLocal);
    } catch (error) {
      throw CacheException(
        message: error.toString(),
      );
    }
  }

  @override
  Future<bool> checkAuthStatus() async {
    try {
      final userDataBox = await Hive.openBox(
        HiveBoxName.userDataBox,
      );

      if (userDataBox.isEmpty) {
        return false;
      } else {
        return true;
      }
    } catch (error) {
      throw CacheException(
        message: error.toString(),
      );
    }
  }
}
