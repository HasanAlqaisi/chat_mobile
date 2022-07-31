import 'package:chat_mobile/core/network/logging_interceptor.dart';
import 'package:chat_mobile/core/network/token_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DioClient {
  late Dio dio;
  final LoggingInterceptors loggingInterceptors;
  final TokenInterceptors tokenInterceptors;

  DioClient({
    required this.loggingInterceptors,
    required this.tokenInterceptors,
  }) {
    dio = Dio();
    dio.options.baseUrl = 'http://192.168.0.102:3000';
    dio.interceptors.addAll([loggingInterceptors, tokenInterceptors]);
  }
}

final dioProvider = Provider(((ref) {
  final loggingInterceptors = ref.watch(loggingInterceptorsProvider);
  final tokenInterceptors = ref.watch(tokenInterceptorsProvider);

  return DioClient(
    loggingInterceptors: loggingInterceptors,
    tokenInterceptors: tokenInterceptors,
  );
}));
