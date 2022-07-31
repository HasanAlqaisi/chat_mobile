import 'package:chat_mobile/app/auth/data/auth_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignupController extends StateNotifier<AsyncValue<String?>> {
  final AuthRepo authRepo;

  SignupController(this.authRepo) : super(const AsyncData(null));

  Future<void> signup(
    String username,
    String phoneNumber,
    String password,
  ) async {
    state = const AsyncLoading();

    final signup = authRepo.signup;

    state =
        await AsyncValue.guard(() => signup(username, phoneNumber, password));
  }
}

final signupControllerProvider =
    StateNotifierProvider.autoDispose<SignupController, AsyncValue<String?>>(
  (ref) {
    final authRepo = ref.watch(authRepoProvider);

    return SignupController(authRepo);
  },
);
