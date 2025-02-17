import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);
}

class ServerFailure extends Failure {
  final int? erroCode;

  const ServerFailure(this.erroCode,
      [String message = 'error occurred while processing request'])
      : super(message);

  @override
  List<Object?> get props => [
        message,
      ];
}

class CacheFailure extends Failure {
  const CacheFailure(
      [super.message = 'error occurred while processing request']);

  @override
  List<Object?> get props => [
        message,
      ];
}

class NetworkFailure extends Failure {
  const NetworkFailure(
      [super.message = 'error occurred while processing request']);

  @override
  List<Object?> get props => [
        message,
      ];
}

class UnknownFailure extends Failure {
  const UnknownFailure(
      [super.message = 'error occurred while processing request']);

  @override
  List<Object?> get props => [
        message,
      ];
}
