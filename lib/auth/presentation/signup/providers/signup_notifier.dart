import 'package:chat_mobile/auth/data/auth_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignupNotifier extends StateNotifier<AsyncValue<String?>> {
  final AuthRepo authRepo;

  SignupNotifier(this.authRepo) : super(const AsyncData(null));

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

final signupNotifierProvider =
    StateNotifierProvider.autoDispose<SignupNotifier, AsyncValue<String?>>(
  (ref) {
    final authRepo = ref.watch(authRepoProvider);

    return SignupNotifier(authRepo);
  },
);
