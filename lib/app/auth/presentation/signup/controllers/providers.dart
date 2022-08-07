import 'package:chat_mobile/app/auth/presentation/signup/controllers/signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final usernameSignupProvider = StateProvider.autoDispose((ref) => '');
final phoneSignupProvider = StateProvider.autoDispose((ref) => '');
final passwordSignupProvider = StateProvider.autoDispose((ref) => '');

final signupFormKeyProvider = Provider((ref) => GlobalKey<FormState>());

final signupButtonEnabled = Provider.autoDispose((ref) {
  final username = ref.watch(usernameSignupProvider);
  final phone = ref.watch(phoneSignupProvider);
  final password = ref.watch(passwordSignupProvider);
  final signupControllerState = ref.watch(signupControllerProvider);

  return username.trim().isNotEmpty &&
      phone.trim().isNotEmpty &&
      password.trim().isNotEmpty &&
      signupControllerState is! AsyncLoading;
});
