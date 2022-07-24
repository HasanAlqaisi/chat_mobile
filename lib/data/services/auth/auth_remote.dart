import 'dart:developer' show log;

import 'package:chat_mobile/data/models/auth/login_info.dart';
import 'package:chat_mobile/utils/errors/exceptions.dart';
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
    try {
      final res = await dioClient.dio.post<String>('/users/signup', data: {
        'username': username,
        'phoneNumber': phoneNumber,
        'password': password,
      });

      return res.data!;
    } catch (error) {
      log('ERROR $error', name: 'http_auth.dart:signup');
      throw ApiUnkownException();
    }
  }

  Future<LoginInfo> login(String phoneNumber, String password) async {
    try {
      final res = await dioClient.dio.post('/users/login', data: {
        'phoneNumber': phoneNumber,
        'password': password,
      });
      log("result ${res.data}", name: 'http_auth.dart:login');
      return LoginInfo.fromMap(res.data);
    } catch (error) {
      log("Error $error", name: 'http_auth.dart:login');
      throw ApiUnkownException();
    }
  }

  Future<String> verifyOtp(String phoneNumber, String otp) async {
    try {
      final res = await dioClient.dio.post<String>('/users/verify-otp', data: {
        'phoneNumber': phoneNumber,
        'otp': otp,
      });

      log("result ${res.data}", name: 'http_auth.dart:verifyOtp');
      return res.data.toString();
    } catch (error) {
      log("Error $error", name: 'http_auth.dart:verifyOtp');
      throw ApiUnkownException();
    }
  }

  Future<String> resendOtp(String phoneNumber) async {
    try {
      final res = await dioClient.dio.post<String>('/users/resend-otp', data: {
        'phoneNumber': phoneNumber,
      });

      log("result ${res.data}", name: 'http_auth.dart:resendOtp');
      return res.data.toString();
    } catch (error) {
      log("Error $error", name: 'http_auth.dart:resendOtp');
      throw ApiUnkownException();
    }
  }
}

final authRemoteProvider = Provider<AuthRemote>(((ref) {
  final dioClient = ref.watch(dioProvider);

  return AuthRemote(dioClient: dioClient);
}));
