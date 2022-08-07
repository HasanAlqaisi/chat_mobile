import 'dart:developer' show log;

import 'package:auto_route/auto_route.dart';
import 'package:chat_mobile/core/services/secure_storage.dart';
import 'package:chat_mobile/routers/app_router.gr.dart';
import 'package:chat_mobile/utils/constants/secrets.dart';
import 'package:chat_mobile/utils/errors/exceptions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jwt_decode/jwt_decode.dart';

final authGuardProvider = Provider((ref) {
  final secureStorage = ref.watch(appSecureStorageProvider);

  return AuthGuard(secureStorage: secureStorage);
});

class AuthGuard extends AutoRouteGuard {
  final SecureStorage secureStorage;

  AuthGuard({required this.secureStorage});

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    log('checking token...', name: 'auth_guard.dart:onNavigation');

    try {
      final token = await secureStorage.readToken(Secrets.tokenKey);
      if (token != null && !Jwt.isExpired(token)) {
        resolver.next(true);
      } else {
        await secureStorage.writeToken(Secrets.tokenKey, null);

        router.pushAndPopUntil(const LoginRoute(), predicate: (_) => false);

        Fluttertoast.showToast(msg: "session ended! Please login.");

        resolver.next(false);
      }
    } on UserNotAuthedException {
      router.pushAndPopUntil(const LoginRoute(), predicate: (_) => false);
      resolver.next(false);
    }
  }
}
