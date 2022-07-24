import 'package:chat_mobile/auth/data/auth_repo.dart';
import 'package:chat_mobile/auth/presentation/signup/providers/state_providers.dart';
import 'package:chat_mobile/utils/errors/data_or_failure.dart';
import 'package:chat_mobile/utils/errors/failures.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VerifyOtpNotifier extends StateNotifier<DataOrFailure<String, Failure>?> {
  final Ref ref;
  final AuthRepo authRepo;
  final String _phoneNumber;

  VerifyOtpNotifier(this.ref, this.authRepo, this._phoneNumber)
      : super(DataOrFailure());

  Future<void> verifyOtp(String otp) async {
    state = null;
    final result = await authRepo.verifyOtp(_phoneNumber, otp);
    state = result;
  }

  Future<void> resendOtp(
    String phoneNumber,
  ) async {
    state = null;
    final result = await authRepo.resendOtp(phoneNumber);
    state = result;
  }
}

class ResendOtpNotifier extends StateNotifier<DataOrFailure<String, Failure>?> {
  final Ref ref;
  final AuthRepo authRepo;
  final String _phoneNumber;

  ResendOtpNotifier(this.ref, this.authRepo, this._phoneNumber)
      : super(DataOrFailure());

  Future<void> resendOtp() async {
    state = null;
    final result = await authRepo.resendOtp(_phoneNumber);
    state = result;
  }
}

final verifyOtpNotifierProvider = StateNotifierProvider.autoDispose<
    VerifyOtpNotifier, DataOrFailure<String, Failure>?>(
  (ref) {
    final authRepo = ref.watch(authRepoProvider);
    final phoneNumber = ref.watch(phoneSignupProvider);
    return VerifyOtpNotifier(ref, authRepo, phoneNumber);
  },
);

final resendOtpNotifierProvider = StateNotifierProvider.autoDispose<
    ResendOtpNotifier, DataOrFailure<String, Failure>?>(
  (ref) {
    final authRepo = ref.watch(authRepoProvider);
    final phoneNumber = ref.watch(phoneSignupProvider);
    return ResendOtpNotifier(ref, authRepo, phoneNumber);
  },
);
