import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'app_network.dart';

@module
abstract class DioModule {
  @singleton
  Dio get instance {
    Dio dio = Dio(BaseOptions(
      receiveDataWhenStatusError: true,
      responseType: ResponseType.json,
      connectTimeout: AppNetwork.connectionTimeout,
      receiveTimeout: AppNetwork.receiveTimeout,
      headers: {
        'content-type': 'application/json',
      },
    ));
    dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
    ));

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
        options.extra['requestTime'] = DateTime.now().millisecondsSinceEpoch;
        debugPrint('Sending request: ${options.method} ${options.path}');
        handler.next(options);
      },
      onResponse: (Response response, ResponseInterceptorHandler handler) {
        final requestTime = response.requestOptions.extra['requestTime'];
        final responseTime = DateTime.now().millisecondsSinceEpoch;
        final resultTime = responseTime - requestTime;
        log('${response.requestOptions.uri.path}  Response Time: $resultTime ms');

        debugPrint(
            'Received response: ${response.statusCode} ${response.statusMessage}');
        handler.next(response);
      },
      onError: (DioException error, ErrorInterceptorHandler handler) {
        debugPrint('Caught error: ${error.message}');
        handler.next(error);
      },
    ));

    return dio;
  }
}
