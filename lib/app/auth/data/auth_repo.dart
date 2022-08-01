import 'dart:developer';

import 'package:chat_mobile/app/auth/data/auth_local.dart';
import 'package:chat_mobile/app/auth/data/auth_remote.dart';
import 'package:chat_mobile/app/auth/domain/login_info.dart';
import 'package:chat_mobile/app/auth/domain/user.dart';
import 'package:chat_mobile/core/database/database.dart';
import 'package:chat_mobile/utils/constants/secrets.dart';
import 'package:chat_mobile/utils/errors/exceptions.dart';
import 'package:chat_mobile/core/services/secure_storage.dart';
import 'package:chat_mobile/utils/extensions/jwt_extension.dart';
import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthRepo {
  final AuthRemote authRemote;
  final AuthLocal authLocal;
  final SecureStorage secureStorage;

  AuthRepo({
    required this.authRemote,
    required this.authLocal,
    required this.secureStorage,
  });

  Future<String> getTokenFromStorage() async {
    final token = await secureStorage.readToken(Secrets.tokenKey);

    if (token == null) throw UserNotAuthedException();

    return token;
  }

  Future<String> signup(
    String username,
    String phoneNumber,
    String password,
  ) async {
    try {
      final result = await authRemote.signup(username, phoneNumber, password);

      return result;
    } catch (_) {
      rethrow;
    }
  }

  Future<LoginInfo> login(
    String phoneNumber,
    String password,
  ) async {
    try {
      final result = await authRemote.login(phoneNumber, password);

      await secureStorage.writeToken(Secrets.tokenKey, result.accessToken);

      final user = result.user;

      await authLocal.upsertUser(UsersCompanion.insert(
        id: user.id,
        username: user.username,
        phoneNumber: user.phoneNumber,
        firstName: Value(user.firstName),
        lastName: Value(user.lastName),
        profileImage: Value(user.profileImage),
        lastVisibleDate: user.lastVisibleDate,
      ));

      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> verifyOtp(
    String phoneNumber,
    String password,
  ) async {
    try {
      final result = await authRemote.verifyOtp(phoneNumber, password);

      return result;
    } catch (_) {
      rethrow;
    }
  }

  Future<String> resendOtp(String phoneNumber) async {
    try {
      final result = await authRemote.resendOtp(phoneNumber);

      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<User>> searchUsers(String? query) async {
    try {
      final result = await authRemote.searchUsers(query);

      final insertableUsers = result
          .map((user) => UsersCompanion.insert(
              id: user.id,
              username: user.username,
              phoneNumber: user.phoneNumber,
              firstName: Value(user.firstName),
              lastName: Value(user.lastName),
              profileImage: Value(user.profileImage),
              lastVisibleDate: user.lastVisibleDate))
          .toList();

      await authLocal.upsertUsers(insertableUsers);

      return result;
    } catch (e) {
      rethrow;
    }
  }

  Stream<List<User>> watchUsers(String? currentUserId) =>
      authLocal.watchUsers(currentUserId);
}

final authRepoProvider = Provider<AuthRepo>((ref) {
  final authRemote = ref.watch(authRemoteProvider);
  final appSecureStorage = ref.watch(appSecureStorageProvider);
  final authLocal = ref.watch(authLocalProvider);

  return AuthRepo(
    authRemote: authRemote,
    secureStorage: appSecureStorage,
    authLocal: authLocal,
  );
});
