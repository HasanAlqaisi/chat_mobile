import 'dart:developer' show log;

import 'package:auto_route/auto_route.dart';
import 'package:chat_mobile/routers/app_paths.dart';
import 'package:chat_mobile/utils/constants/secrets.dart';
import 'package:chat_mobile/utils/storage/secure_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authGuardProvider = Provider((ref) {
  final secureStorage = ref.watch(appSecureStorageProvider);

  return AuthGuard(secureStorage: secureStorage);
});

class AuthGuard extends AutoRouteGuard {
  final SecureStorage secureStorage;

  AuthGuard({required this.secureStorage});

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    log('getting token...', name: 'auth_guard.dart:onNavigation');

    final token = await secureStorage.readToken(Secrets.tokenKey);

    if (token != null) {
      resolver.next(true);
    } else {
      router.pushNamed(AppPaths.login);
      resolver.next(false);
    }
  }
}
