import 'dart:io';

import 'package:chat_mobile/app/shared/domain/user.dart';
import 'package:chat_mobile/core/network/dio_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileRemote {
  final DioClient dioClient;

  ProfileRemote({required this.dioClient});

  Future<User> editProfile(
    File profileImage,
    String username,
    String firstname,
    String lastname,
  ) async {
    final fileName = profileImage.path.split('/').last;

    final formData = FormData.fromMap({
      'profileImage':
          await MultipartFile.fromFile(profileImage.path, filename: fileName),
      "username": username,
      "firstName": firstname,
      "lastName": lastname,
    });

    final res = await dioClient.dio.patch(
      '/users/profile',
      options: Options(
        headers: {'requireToken': true},
        contentType: 'multipart/form-data',
      ),
      data: formData,
    );

    return User.fromJson(res.data);
  }

  Future<User> getProfile() async {
    final res = await dioClient.dio.get(
      '/users/profile',
      options: Options(headers: {'requireToken': true}),
    );

    return User.fromJson(res.data);
  }
}

final profileRemoteProvider = Provider<ProfileRemote>(((ref) {
  final dioClient = ref.watch(dioClientProvider);

  return ProfileRemote(dioClient: dioClient);
}));
