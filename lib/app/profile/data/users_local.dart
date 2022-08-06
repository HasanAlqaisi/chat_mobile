import 'package:chat_mobile/app/auth/domain/user.dart';
import 'package:chat_mobile/core/database/dao/users_dao.dart';
import 'package:chat_mobile/core/database/database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UsersLocal {
  final UsersDao usersDao;

  UsersLocal({required this.usersDao});

  Future<void> upsertUser(UsersCompanion user) async =>
      await usersDao.upsertUser(user);

  Stream<User?> watchProfile(String? currentUserId) =>
      usersDao.watchUser(currentUserId);
}

final usersLocalProvider = Provider((ref) {
  final usersDao = ref.watch(usersDaoProvider);

  return UsersLocal(usersDao: usersDao);
});
