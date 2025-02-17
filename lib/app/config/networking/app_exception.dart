class ServerException implements Exception {
  final String message;
  final int? statusCode;
  final StackTrace? stackTrace;

  ServerException({
    this.message = 'Server Error',
    this.statusCode = 500,
    this.stackTrace,
  });

  @override
  String toString() {
    return 'ServerException(message: $message, statusCode: $statusCode, stackTrace: $stackTrace)';
  }
}

class CacheException implements Exception {
  final String message;

  CacheException({
    this.message = 'Cache Error',
  });

  @override
  String toString() {
    return 'CacheException(message: $message)';
  }
}
