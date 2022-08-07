import 'package:chat_mobile/app/shared/domain/user.dart';
import 'package:chat_mobile/core/database/database.dart';
import 'package:chat_mobile/core/database/tables.dart';
import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'users_dao.g.dart';

@DriftAccessor(tables: [Users])
class UsersDao extends DatabaseAccessor<AppDatabase> with _$UsersDaoMixin {
  UsersDao(AppDatabase db) : super(db);

  Future<void> upsertUsers(
    List<User> usersList,
    String? currentUserId,
  ) async {
    final companionUsers = usersList
        .map(
          (user) => UsersCompanion.insert(
              id: user.id,
              username: user.username,
              phoneNumber: user.phoneNumber,
              firstName: Value(user.firstName),
              lastName: Value(user.lastName),
              profileImage: Value(user.profileImage),
              lastVisibleDate: user.lastVisibleDate),
        )
        .toList();

    await batch((batch) {
      batch.deleteWhere<$UsersTable, User>(
          users, (row) => row.id.equals(currentUserId).not());

      batch.insertAllOnConflictUpdate(users, companionUsers);
    });
  }

  Future<void> upsertUser(User user) async {
    await into(users).insertOnConflictUpdate(UsersCompanion.insert(
      id: user.id,
      username: user.username,
      phoneNumber: user.phoneNumber,
      firstName: Value(user.firstName),
      lastName: Value(user.lastName),
      profileImage:
          Value.ofNullable(user.profileImage == "" ? null : user.profileImage),
      lastVisibleDate: user.lastVisibleDate,
    ));
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

  Stream<User?> watchUser(String? currentUserId) {
    return (select(users)..where((user) => user.id.equals(currentUserId)))
        .watchSingleOrNull();
  }
}

final usersDaoProvider = Provider((ref) {
  final db = ref.watch(appDatabaseProvider);

  return UsersDao(db);
});
