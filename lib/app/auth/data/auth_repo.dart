import 'package:chat_mobile/app/auth/data/auth_local.dart';
import 'package:chat_mobile/app/auth/data/auth_remote.dart';
import 'package:chat_mobile/app/auth/domain/login_info.dart';
import 'package:chat_mobile/core/providers.dart';
import 'package:chat_mobile/core/shared/domain/user.dart';
import 'package:chat_mobile/utils/constants/secrets.dart';
import 'package:chat_mobile/utils/errors/exceptions.dart';
import 'package:chat_mobile/core/services/secure_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthRepo {
  final Ref ref;
  final AuthRemote authRemote;
  final AuthLocal authLocal;
  final SecureStorage secureStorage;

  AuthRepo({
    required this.ref,
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

      ref.refresh(tokenProvider);

      final user = result.user;

      await authLocal.upsertUser(user);

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

  Future<List<User>> searchUsers(String? query, String? currentUserId) async {
    try {
      final users = await authRemote.searchUsers(query);

      await authLocal.upsertUsers(users, currentUserId);

      return users;
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
    ref: ref,
    authRemote: authRemote,
    secureStorage: appSecureStorage,
    authLocal: authLocal,
  );
});
