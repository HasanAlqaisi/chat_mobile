import 'package:chat_mobile/auth/data/auth_remote.dart';
import 'package:chat_mobile/auth/domain/login_info.dart';
import 'package:chat_mobile/auth/domain/user.dart';
import 'package:chat_mobile/utils/constants/secrets.dart';
import 'package:chat_mobile/utils/errors/exceptions.dart';
import 'package:chat_mobile/utils/extensions/jwt.dart';
import 'package:chat_mobile/utils/storage/secure_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthRepo {
  final AuthRemote authRemote;
  final SecureStorage secureStorage;

  AuthRepo({
    required this.authRemote,
    required this.secureStorage,
  });

  Future<String> get getUserId async {
    try {
      final token = await _getTokenFromStorage();

      final uid = JwtExtension.getUserId(token);

      return uid;
    } catch (_) {
      rethrow;
    }
  }

  Future<String> _getTokenFromStorage() async {
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

      return result;
    } catch (e) {
      rethrow;
    }
  }
}

final authRepoProvider = Provider<AuthRepo>((ref) {
  final httpAuth = ref.watch(authRemoteProvider);
  final appSecureStorage = ref.watch(appSecureStorageProvider);

  return AuthRepo(authRemote: httpAuth, secureStorage: appSecureStorage);
});
