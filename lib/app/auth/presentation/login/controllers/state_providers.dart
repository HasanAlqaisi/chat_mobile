import 'package:chat_mobile/app/auth/presentation/login/controllers/login_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginPhoneTextProvider = StateProvider.autoDispose((ref) => '');
final loginPasswordTextProvider = StateProvider.autoDispose((ref) => '');

final buttonEnabledProvider = Provider.autoDispose<bool>((ref) {
  final phoneNumber = ref.watch(loginPhoneTextProvider);
  final password = ref.watch(loginPasswordTextProvider);
  final loginControllerState = ref.watch(loginControllerProvider);

  return phoneNumber.trim().isNotEmpty &&
      password.trim().isNotEmpty &&
      loginControllerState is! AsyncLoading;
});
