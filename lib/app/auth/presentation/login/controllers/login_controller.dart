import 'package:chat_mobile/app/auth/data/auth_repo.dart';
import 'package:chat_mobile/app/auth/domain/login_info.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginController extends StateNotifier<AsyncValue<LoginInfo?>> {
  late AuthRepo loginRepo;

  LoginController(this.loginRepo) : super(const AsyncValue.data(null));

  Future<void> login(String phoneNumber, String password) async {
    state = const AsyncValue.loading();

    final login = loginRepo.login;

    state = await AsyncValue.guard(() => login(phoneNumber, password));
  }
}

final loginControllerProvider =
    StateNotifierProvider.autoDispose<LoginController, AsyncValue<LoginInfo?>>(
  (ref) {
    final authRepo = ref.watch(authRepoProvider);

    return LoginController(authRepo);
  },
);
