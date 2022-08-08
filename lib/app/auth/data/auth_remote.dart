import 'package:chat_mobile/app/auth/domain/login_info.dart';
import 'package:chat_mobile/app/shared/domain/user.dart';
import 'package:chat_mobile/core/network/dio_client.dart';
import 'package:dio/dio.dart';
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

    return LoginInfo.fromJson(res.data);
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

  Future<List<User>> searchUsers(String? query) async {
    final res = await dioClient.dio.get(
      '/users/',
      options: Options(headers: {'requireToken': true}),
      queryParameters: {
        'query': query,
      },
    );

    return (res.data as List).map((user) => User.fromJson(user)).toList();
  }
}

final authRemoteProvider = Provider<AuthRemote>(((ref) {
  final dioClient = ref.watch(dioProvider);

  return AuthRemote(dioClient: dioClient);
}));
