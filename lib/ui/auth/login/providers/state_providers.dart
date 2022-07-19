import 'package:chat_mobile/ui/auth/login/providers/login_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final phoneTextProvider = StateProvider.autoDispose((ref) => '');
final passwordTextProvider = StateProvider.autoDispose((ref) => '');

final buttonEnabledProvider = Provider.autoDispose<bool>((ref) {
  final phoneNumber = ref.watch(phoneTextProvider);
  final password = ref.watch(passwordTextProvider);
  final loginNotifier = ref.watch(loginNotifierProvider);

  return phoneNumber.trim().isNotEmpty &&
      password.trim().isNotEmpty &&
      loginNotifier != null;
});
