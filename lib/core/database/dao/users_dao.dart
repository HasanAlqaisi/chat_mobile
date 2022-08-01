import 'package:chat_mobile/app/auth/domain/user.dart';
import 'package:chat_mobile/core/database/database.dart';
import 'package:chat_mobile/core/database/tables.dart';
import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'users_dao.g.dart';

@DriftAccessor(tables: [Users])
class UsersDao extends DatabaseAccessor<AppDatabase> with _$UsersDaoMixin {
  UsersDao(AppDatabase db) : super(db);

  Future<void> upsertUsers(
    // String currentUserId,
    List<UsersCompanion> usersList,
  ) async {
    await batch((batch) {
      // TODO: should not delete current user id
      batch.deleteWhere(users, (row) => const Constant(true));
      batch.insertAllOnConflictUpdate(users, usersList);
    });
  }

  Future<void> upsertUser(
    // String currentUserId,
    UsersCompanion user,
  ) async {
    await into(users).insertOnConflictUpdate(user);
  }

  // watch all users except the current one
  // when their username or phone number match the query.
  Stream<List<User>> watchUsers(String? currentUserId) {
    return (select(users)
          ..where((user) => user.id.equals(currentUserId).not()
              // &
              // (users.username.like('%$query%') |
              // users.phoneNumber.like('%$query%')),
              ))
        .watch();
  }
}

final usersDaoProvider = Provider((ref) {
  final db = ref.watch(appDatabaseProvider);

  return UsersDao(db);
});
