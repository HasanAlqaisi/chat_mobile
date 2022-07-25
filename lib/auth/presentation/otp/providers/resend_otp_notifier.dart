import 'package:chat_mobile/auth/data/auth_repo.dart';
import 'package:chat_mobile/auth/presentation/signup/providers/state_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResendOtpNotifier extends StateNotifier<AsyncValue<String?>> {
  final AuthRepo authRepo;
  final String _phoneNumber;

  ResendOtpNotifier(this.authRepo, this._phoneNumber)
      : super(const AsyncLoading());

  Future<void> resendOtp() async {
    state = const AsyncLoading();

    final resendOtp = authRepo.resendOtp;

    state = await AsyncValue.guard(() => resendOtp(_phoneNumber));
  }
}

final resendOtpNotifierProvider =
    StateNotifierProvider.autoDispose<ResendOtpNotifier, AsyncValue<String?>>(
  (ref) {
    final authRepo = ref.watch(authRepoProvider);

    final phoneNumber = ref.watch(phoneSignupProvider);

    return ResendOtpNotifier(authRepo, phoneNumber);
  },
);
