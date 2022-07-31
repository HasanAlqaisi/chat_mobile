import 'dart:developer' show log;

import 'package:auto_route/auto_route.dart';
import 'package:chat_mobile/routers/app_paths.dart';
import 'package:chat_mobile/core/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jwt_decode/jwt_decode.dart';

final authGuardProvider = Provider((ref) {
  return AuthGuard(ref: ref);
});

class AuthGuard extends AutoRouteGuard {
  final Ref ref;

  AuthGuard({required this.ref});

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    log('checking token...', name: 'auth_guard.dart:onNavigation');

    final token = await ref.watch(tokenProvider.future);

    // log(!Jwt.isExpired(token));

    if (!Jwt.isExpired(token)) {
      resolver.next(true);
    } else {
      router.pushNamed(AppPaths.login);
      resolver.next(false);
    }
  }
}
