import 'package:chat_mobile/repos/auth/auth_repo.dart';
import 'package:chat_mobile/utils/errors/data_or_failure.dart';
import 'package:chat_mobile/utils/errors/failures.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginNotifier extends StateNotifier<DataOrFailure<dynamic, Failure>?> {
  final Ref ref;
  late AuthRepo loginRepo;

  LoginNotifier(this.ref, this.loginRepo) : super(DataOrFailure());

  Future<void> login(String phoneNumber, String password) async {
    state = null;
    final result = await loginRepo.login(phoneNumber, password);
    state = result;
  }
}

final loginNotifierProvider = StateNotifierProvider.autoDispose<LoginNotifier,
    DataOrFailure<dynamic, Failure>?>(
  (ref) {
    final loginRepo = ref.watch(authRepoProvider);

    return LoginNotifier(ref, loginRepo);
  },
);
