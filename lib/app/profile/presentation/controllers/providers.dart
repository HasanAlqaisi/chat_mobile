import 'dart:io';

import 'package:chat_mobile/app/profile/data/users_repo.dart';
import 'package:chat_mobile/core/shared/domain/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final usernameProfileProvider =
    StateProvider.autoDispose((ref) => TextEditingController());
final firstnameProfileProvider =
    StateProvider.autoDispose((ref) => TextEditingController());
final lastNameProfileProvider =
    StateProvider.autoDispose((ref) => TextEditingController());
final passwordProfileProvider =
    StateProvider.autoDispose((ref) => TextEditingController());

final imageFileProvider = StateProvider<File?>((ref) => null);

final shouldShowFileImageProvider = StateProvider((ref) => false);

final formKeyProvider = Provider.autoDispose((ref) => GlobalKey<FormState>());

final userStreamProvider =
    StreamProvider.family<User?, String?>((ref, currentUserId) {
  final profileRepo = ref.watch(profileRepoProvider);

  return profileRepo.watchProfile(currentUserId);
});
