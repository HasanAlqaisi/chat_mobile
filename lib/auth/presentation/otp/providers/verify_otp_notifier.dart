import 'package:chat_mobile/auth/data/auth_repo.dart';
import 'package:chat_mobile/auth/presentation/signup/providers/state_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VerifyOtpNotifier extends StateNotifier<AsyncValue<String?>> {
  final Ref ref;
  final AuthRepo authRepo;
  final String _phoneNumber;

  VerifyOtpNotifier(this.ref, this.authRepo, this._phoneNumber)
      : super(const AsyncValue.data(null));

  Future<void> verifyOtp(String otp) async {
    state = const AsyncLoading();

    final verifyOtp = authRepo.verifyOtp;

    state = await AsyncValue.guard(() => verifyOtp(_phoneNumber, otp));
  }
}

final verifyOtpNotifierProvider =
    StateNotifierProvider.autoDispose<VerifyOtpNotifier, AsyncValue<String?>>(
  (ref) {
    final authRepo = ref.watch(authRepoProvider);

    final phoneNumber = ref.watch(phoneSignupProvider);

    return VerifyOtpNotifier(ref, authRepo, phoneNumber);
  },
);
