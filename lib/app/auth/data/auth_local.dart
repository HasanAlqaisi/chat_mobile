import 'package:chat_mobile/core/database/dao/users_dao.dart';
import 'package:chat_mobile/core/shared/domain/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthLocal {
  final UsersDao usersDao;

  AuthLocal({required this.usersDao});

  Future<void> upsertUsers(
    List<User> users,
    String? currentUserId,
  ) async =>
      await usersDao.upsertUsers(users, currentUserId);

  Future<void> upsertUser(User user) async => await usersDao.upsertUser(user);

  Stream<List<User>> watchUsers(String? currentUserId) =>
      usersDao.watchUsers(currentUserId);
}

final authLocalProvider = Provider((ref) {
  final usersDao = ref.watch(usersDaoProvider);

  return AuthLocal(usersDao: usersDao);
});
