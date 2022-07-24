import 'dart:developer' show log;

import 'package:chat_mobile/routers/app_router.dart';
import 'package:chat_mobile/routers/app_router.gr.dart';
import 'package:chat_mobile/utils/constants/secrets.dart';
import 'package:chat_mobile/utils/storage/secure_storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jwt_decode/jwt_decode.dart';

class TokenInterceptors extends Interceptor {
  final SecureStorage secureStorage;
  final AppRouter appRouter;

  TokenInterceptors({
    required this.secureStorage,
    required this.appRouter,
  });

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    log('REQUEST[${options.method}]x => PATH: ${options.path}');

    if (options.headers.containsKey('requireToken')) {
      options.headers.remove("requiresToken");

      final token = await secureStorage.readToken(Secrets.tokenKey);

      if (!Jwt.isExpired(token!)) {
        options.headers.addAll({'Authorization': 'Bearer $token'});

        handler.next(options);
      } else {
        await secureStorage.writeToken(Secrets.tokenKey, null);

        appRouter.pushAndPopUntil(const LoginRoute(), predicate: (_) => false);

        Fluttertoast.showToast(msg: "session ended! Please login.");

        handler.resolve(Response(requestOptions: options));
      }
    }
    handler.next(options);
  }
}

final tokenInterceptorsProvider = Provider((ref) {
  final secureStorage = ref.watch(appSecureStorageProvider);
  final appRouter = ref.watch(appRouterProvider);

  return TokenInterceptors(secureStorage: secureStorage, appRouter: appRouter);
});