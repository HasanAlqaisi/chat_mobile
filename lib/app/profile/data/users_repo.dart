import 'dart:io';

import 'package:chat_mobile/app/shared/domain/user.dart';
import 'package:chat_mobile/app/profile/data/users_local.dart';
import 'package:chat_mobile/app/profile/data/users_remote.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileRepo {
  final ProfileRemote profileRemote;
  final UsersLocal usersLocal;

  ProfileRepo({required this.profileRemote, required this.usersLocal});

  Future<User?> editProfile(
    File profileImage,
    String username,
    String firstname,
    String lastname,
  ) async {
    try {
      final user = await profileRemote.editProfile(
          profileImage, username, firstname, lastname);

      return user;
    } catch (_) {
      rethrow;
    }
  }

  Future<User> getProfile() async {
    try {
      final user = await profileRemote.getProfile();

      await usersLocal.upsertUser(user);

      return user;
    } catch (_) {
      rethrow;
    }
  }

  Stream<User?> watchProfile(String? userId) => usersLocal.watchProfile(userId);
}

final profileRepoProvider = Provider<ProfileRepo>((ref) {
  final profileRemote = ref.watch(profileRemoteProvider);
  final usersLocal = ref.watch(usersLocalProvider);

  return ProfileRepo(profileRemote: profileRemote, usersLocal: usersLocal);
});
