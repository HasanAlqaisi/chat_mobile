import 'package:chat_mobile/auth/presentation/signup/providers/signup_notifier.dart';
import 'package:chat_mobile/utils/errors/failures.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final usernameSignupProvider = StateProvider.autoDispose((ref) => '');
final phoneSignupProvider = StateProvider.autoDispose((ref) => '');
final passwordSignupProvider = StateProvider.autoDispose((ref) => '');

final signupButtonEnabled = Provider.autoDispose((ref) {
  final username = ref.watch(usernameSignupProvider);
  final phone = ref.watch(phoneSignupProvider);
  final password = ref.watch(passwordSignupProvider);
  final data = ref.watch(signupNotifierProvider);

  return username.trim().isNotEmpty &&
      phone.trim().isNotEmpty &&
      password.trim().isNotEmpty &&
      data is! AsyncLoading;
});

final fieldsFailureProvider =
    StateProvider.autoDispose<ApiFieldsFailure?>((ref) => null);
