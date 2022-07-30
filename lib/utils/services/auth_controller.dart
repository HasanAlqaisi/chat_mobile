import 'package:chat_mobile/auth/data/auth_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthController extends StateNotifier<AsyncValue<String?>> {
  final AuthRepo authRepo;

  AuthController({
    required this.authRepo,
  }) : super(const AsyncData(null));

  Future<void> getUserId() async {
    state = const AsyncLoading();

    final getUserId = authRepo.getUserId;

    state = await AsyncValue.guard(() => getUserId);
  }
}

final authControllerProvider =
    StateNotifierProvider<AuthController, AsyncValue<String?>>((ref) {
  final authRepo = ref.watch(authRepoProvider);

  return AuthController(authRepo: authRepo);
});
