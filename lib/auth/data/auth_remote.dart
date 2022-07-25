import 'package:chat_mobile/auth/domain/login_info.dart';
import 'package:chat_mobile/utils/services/http.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthRemote {
  final DioClient dioClient;

  AuthRemote({required this.dioClient});

  Future<String> signup(
    String username,
    String phoneNumber,
    String password,
  ) async {
    final res = await dioClient.dio.post<String>('/users/signup', data: {
      'username': username,
      'phoneNumber': phoneNumber,
      'password': password,
    });

    return res.data!;
  }

  Future<LoginInfo> login(String phoneNumber, String password) async {
    final res = await dioClient.dio.post('/users/login', data: {
      'phoneNumber': phoneNumber,
      'password': password,
    });

    return LoginInfo.fromMap(res.data);
  }

  Future<String> verifyOtp(String phoneNumber, String otp) async {
    final res = await dioClient.dio.post<String>('/users/verify-otp', data: {
      'phoneNumber': phoneNumber,
      'otp': otp,
    });

    return res.data.toString();
  }

  Future<String> resendOtp(String phoneNumber) async {
    final res = await dioClient.dio.post<String>('/users/resend-otp', data: {
      'phoneNumber': phoneNumber,
    });

    return res.data.toString();
  }
}

final authRemoteProvider = Provider<AuthRemote>(((ref) {
  final dioClient = ref.watch(dioProvider);

  return AuthRemote(dioClient: dioClient);
}));