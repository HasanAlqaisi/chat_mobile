import 'dart:developer' show log;

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoggingInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log("--> ${options.method.toUpperCase()} ${"${options.baseUrl}${options.path}"}");

    log("Headers:");
    options.headers.forEach((k, v) => log('$k: $v'));

    log("queryParameters:");
    options.queryParameters.forEach((k, v) => log('$k: $v'));

    if (options.data != null) {
      log("Body: ${options.data}");
    }

    log("--> END ${options.method.toUpperCase()}");

    handler.next(options);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    final path = err.response?.requestOptions.path;
    final baseUrl = err.response?.requestOptions.baseUrl;

    log("<-- ${err.message} ${(err.response?.requestOptions != null ? (baseUrl.toString() + path.toString()) : 'URL')}");
    log("${err.response != null ? err.response?.data : 'Unknown Error'}");
    log("<-- End error");

    handler.next(err);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log("<-- ${response.statusCode} ${((response.requestOptions.baseUrl + response.requestOptions.path))}");

    log("Headers:");
    response.headers.forEach((k, v) => log('$k: $v'));

    log("Response: ${response.data}");

    log("<-- END HTTP");

    handler.next(response);
  }
}

final loggingInterceptorsProvider = Provider((ref) => LoggingInterceptors());
