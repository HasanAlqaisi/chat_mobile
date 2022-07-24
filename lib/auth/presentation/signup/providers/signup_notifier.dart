import 'package:chat_mobile/auth/data/auth_repo.dart';
import 'package:chat_mobile/utils/errors/data_or_failure.dart';
import 'package:chat_mobile/utils/errors/failures.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignupNotifier extends StateNotifier<DataOrFailure<String, Failure>?> {
  final Ref ref;
  final AuthRepo authRepo;

  SignupNotifier(this.ref, this.authRepo) : super(DataOrFailure());

  Future<void> signup(
    String username,
    String phoneNumber,
    String password,
  ) async {
    state = null;
    final result = await authRepo.signup(username, phoneNumber, password);
    state = result;
  }
}

final signupNotifierProvider = StateNotifierProvider.autoDispose<SignupNotifier,
    DataOrFailure<dynamic, Failure>?>(
  (ref) {
    final authRepo = ref.watch(authRepoProvider);

    return SignupNotifier(ref, authRepo);
  },
);
