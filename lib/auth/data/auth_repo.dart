import 'package:chat_mobile/auth/data/auth_remote.dart';
import 'package:chat_mobile/auth/domain/login_info.dart';
import 'package:chat_mobile/utils/constants/secrets.dart';
import 'package:chat_mobile/utils/errors/data_or_failure.dart';
import 'package:chat_mobile/utils/errors/exceptions.dart';
import 'package:chat_mobile/utils/errors/failures.dart';
import 'package:chat_mobile/utils/errors/handle_response_errors.dart';
import 'package:chat_mobile/utils/storage/secure_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthRepo {
  final AuthRemote httpAuth;
  final SecureStorage secureStorage;

  AuthRepo({
    required this.httpAuth,
    required this.secureStorage,
  });

  Future<DataOrFailure<String, Failure>> signup(
    String username,
    String phoneNumber,
    String password,
  ) async {
    try {
      final result = await httpAuth.signup(username, phoneNumber, password);
      return DataOrFailure(data: result);
    } on ApiTimeoutException catch (_) {
      return DataOrFailure(failure: ApiTimeoutFailure());
    } on ApiResponseException catch (error) {
      return DataOrFailure(failure: handleResponseErrors(error));
    } on ApiCancelException catch (_) {
      return DataOrFailure(failure: ApiCancelFailure());
    } on ApiUnkownException catch (_) {
      return DataOrFailure(failure: ApiUnkownFailure());
    } catch (e) {
      return DataOrFailure(failure: ApiUnkownFailure());
    }
  }

  Future<DataOrFailure<LoginInfo, Failure>> login(
    String phoneNumber,
    String password,
  ) async {
    try {
      final result = await httpAuth.login(phoneNumber, password);

      await secureStorage.writeToken(Secrets.tokenKey, result.accessToken);

      return DataOrFailure(data: result);
    } on ApiTimeoutException catch (_) {
      return DataOrFailure(failure: ApiTimeoutFailure());
    } on ApiResponseException catch (error) {
      return DataOrFailure(failure: handleResponseErrors(error));
    } on ApiCancelException catch (_) {
      return DataOrFailure(failure: ApiCancelFailure());
    } on ApiUnkownException catch (_) {
      return DataOrFailure(failure: ApiUnkownFailure());
    } catch (e) {
      return DataOrFailure(failure: ApiUnkownFailure());
    }
  }

  Future<DataOrFailure<String, Failure>> verifyOtp(
    String phoneNumber,
    String password,
  ) async {
    try {
      final result = await httpAuth.verifyOtp(phoneNumber, password);
      return DataOrFailure(data: result);
    } on ApiTimeoutException catch (_) {
      return DataOrFailure(failure: ApiTimeoutFailure());
    } on ApiResponseException catch (error) {
      return DataOrFailure(failure: handleResponseErrors(error));
    } on ApiCancelException catch (_) {
      return DataOrFailure(failure: ApiCancelFailure());
    } on ApiUnkownException catch (_) {
      return DataOrFailure(failure: ApiUnkownFailure());
    } catch (e) {
      return DataOrFailure(failure: ApiUnkownFailure());
    }
  }

  Future<DataOrFailure<String, Failure>> resendOtp(
    String phoneNumber,
  ) async {
    try {
      final result = await httpAuth.resendOtp(phoneNumber);
      return DataOrFailure(data: result);
    } on ApiTimeoutException catch (_) {
      return DataOrFailure(failure: ApiTimeoutFailure());
    } on ApiResponseException catch (error) {
      return DataOrFailure(failure: handleResponseErrors(error));
    } on ApiCancelException catch (_) {
      return DataOrFailure(failure: ApiCancelFailure());
    } on ApiUnkownException catch (_) {
      return DataOrFailure(failure: ApiUnkownFailure());
    } catch (e) {
      return DataOrFailure(failure: ApiUnkownFailure());
    }
  }
}

final authRepoProvider = Provider<AuthRepo>((ref) {
  final httpAuth = ref.watch(authRemoteProvider);
  final appSecureStorage = ref.watch(appSecureStorageProvider);

  return AuthRepo(httpAuth: httpAuth, secureStorage: appSecureStorage);
});
