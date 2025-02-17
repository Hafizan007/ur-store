import 'package:dartz/dartz.dart';

import '../networking/failure.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams {
  NoParams._();
  static final NoParams _instance = NoParams._();
  factory NoParams() => _instance;
}
