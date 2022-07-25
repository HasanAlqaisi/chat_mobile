import 'package:chat_mobile/auth/data/auth_repo.dart';
import 'package:chat_mobile/auth/presentation/signup/controllers/state_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResendOtpController extends StateNotifier<AsyncValue<String?>> {
  final AuthRepo authRepo;
  final String _phoneNumber;

  ResendOtpController(this.authRepo, this._phoneNumber)
      : super(const AsyncLoading());

  Future<void> resendOtp() async {
    state = const AsyncLoading();

    final resendOtp = authRepo.resendOtp;

    state = await AsyncValue.guard(() => resendOtp(_phoneNumber));
  }
}

final resendOtpControllerProvider =
    StateNotifierProvider.autoDispose<ResendOtpController, AsyncValue<String?>>(
  (ref) {
    final authRepo = ref.watch(authRepoProvider);

    final phoneNumber = ref.watch(phoneSignupProvider);

    return ResendOtpController(authRepo, phoneNumber);
  },
);
