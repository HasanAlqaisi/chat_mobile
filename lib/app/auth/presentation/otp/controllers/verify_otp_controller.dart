import 'package:chat_mobile/app/auth/data/auth_repo.dart';
import 'package:chat_mobile/app/auth/presentation/signup/controllers/state_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VerifyOtpController extends StateNotifier<AsyncValue<String?>> {
  final Ref ref;
  final AuthRepo authRepo;
  final String _phoneNumber;

  VerifyOtpController(this.ref, this.authRepo, this._phoneNumber)
      : super(const AsyncValue.data(null));

  Future<void> verifyOtp(String otp) async {
    state = const AsyncLoading();

    final verifyOtp = authRepo.verifyOtp;

    state = await AsyncValue.guard(() => verifyOtp(_phoneNumber, otp));
  }
}

final verifyOtpControllerProvider =
    StateNotifierProvider.autoDispose<VerifyOtpController, AsyncValue<String?>>(
  (ref) {
    final authRepo = ref.watch(authRepoProvider);

    final phoneNumber = ref.watch(phoneSignupProvider);

    return VerifyOtpController(ref, authRepo, phoneNumber);
  },
);
