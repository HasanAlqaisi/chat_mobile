import 'package:chat_mobile/app/auth/data/auth_repo.dart';
import 'package:chat_mobile/app/auth/domain/login_info.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginController extends StateNotifier<AsyncValue<LoginInfo?>> {
  final Ref ref;

  LoginController(this.ref) : super(const AsyncValue.data(null));

  Future<void> login(String phoneNumber, String password) async {
    state = const AsyncValue.loading();

    final login = ref.read(authRepoProvider).login;

    state = await AsyncValue.guard(() => login(phoneNumber, password));
  }
}

final loginControllerProvider =
    StateNotifierProvider.autoDispose<LoginController, AsyncValue<LoginInfo?>>(
  (ref) {
    return LoginController(ref);
  },
);
