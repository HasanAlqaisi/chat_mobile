import 'package:chat_mobile/core/network/logging_interceptor.dart';
import 'package:chat_mobile/core/network/token_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DioClient {
  late Dio dio;
  final LoggingInterceptors loggingInterceptors;
  final TokenInterceptors tokenInterceptors;

  DioClient({
    required this.dio,
    required this.loggingInterceptors,
    required this.tokenInterceptors,
  }) {
    dio.options.baseUrl = 'http://192.168.0.103:3000';
    // dio.options.baseUrl = 'https://chef-escorts-coating-pain.trycloudflare.com';
    dio.interceptors.addAll([loggingInterceptors, tokenInterceptors]);
  }
}

final dioProvider = Provider((_) => Dio());

final dioClientProvider = Provider(((ref) {
  final loggingInterceptors = ref.watch(loggingInterceptorsProvider);
  final tokenInterceptors = ref.watch(tokenInterceptorsProvider);
  final dio = ref.watch(dioProvider);

  return DioClient(
    dio: dio,
    loggingInterceptors: loggingInterceptors,
    tokenInterceptors: tokenInterceptors,
  );
}));
