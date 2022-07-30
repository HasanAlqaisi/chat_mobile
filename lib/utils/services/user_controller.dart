import 'package:chat_mobile/auth/data/auth_repo.dart';
import 'package:chat_mobile/auth/domain/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserController extends StateNotifier<AsyncValue<List<User>>> {
  final AuthRepo authRepo;

  UserController({
    required this.authRepo,
  }) : super(const AsyncData([]));

  Future<void> searchUsers(String? query) async {
    state = const AsyncLoading();

    final searchUsers = authRepo.searchUsers;

    state = await AsyncValue.guard(() => searchUsers(query));
  }
}

final usersControllerProvider =
    StateNotifierProvider.autoDispose<UserController, AsyncValue<List<User>>>(
        (ref) {
  final authRepo = ref.watch(authRepoProvider);

  return UserController(authRepo: authRepo);
});
