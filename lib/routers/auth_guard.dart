import 'dart:developer' show log;

import 'package:auto_route/auto_route.dart';
import 'package:chat_mobile/core/providers.dart';
import 'package:chat_mobile/core/services/secure_storage.dart';
import 'package:chat_mobile/routers/app_router.gr.dart';
import 'package:chat_mobile/utils/constants/secrets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jwt_decode/jwt_decode.dart';

final authGuardProvider = Provider((ref) {
  final secureStorage = ref.watch(appSecureStorageProvider);

  return AuthGuard(ref: ref, secureStorage: secureStorage);
});

class AuthGuard extends AutoRouteGuard {
  final Ref ref;
  final SecureStorage secureStorage;

  AuthGuard({required this.ref, required this.secureStorage});

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    log('checking token...', name: 'auth_guard.dart:onNavigation');

    final token = await ref.read(tokenProvider.future);

    if (token != null) {
      if (!Jwt.isExpired(token)) {
        resolver.next(true);
      } else {
        await secureStorage.writeToken(Secrets.tokenKey, null);

        router.pushAndPopUntil(const LoginRoute(), predicate: (_) => false);

        Fluttertoast.showToast(msg: "session ended! Please login.");

        resolver.next(false);
      }
    } else {
      router.pushAndPopUntil(const LoginRoute(), predicate: (_) => false);

      resolver.next(false);
    }
  }
}
