import 'package:chat_mobile/app/auth/data/auth_local.dart';
import 'package:chat_mobile/app/shared/domain/user.dart';
import 'package:chat_mobile/core/database/dao/users_dao.dart';
import 'package:chat_mobile/core/database/database.dart';
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late ProviderContainer container;
  late AppDatabase appDatabase;
  late AuthLocal authLocal;

  setUp(() {
    appDatabase = AppDatabase(NativeDatabase.memory());

    container = ProviderContainer(overrides: [
      appDatabaseProvider.overrideWithValue(appDatabase),
      usersDaoProvider.overrideWithValue(UsersDao(appDatabase)),
    ]);

    authLocal = container.read(authLocalProvider);
  });

  tearDown(() async {
    await appDatabase.close();
  });

  group('upsertUser', () {
    final user = User(
        id: '1',
        username: 'hasan',
        firstName: 'hasan',
        lastName: 'alqaisi',
        phoneNumber: '+964',
        profileImage: 'oaoa',
        lastVisibleDate: DateTime.now());

    test('create user that does not exist', () async {
      await authLocal.upsertUser(user);

      final userDb = await authLocal.usersDao.watchUser('1').first;

      expect(userDb?.username, user.username);
    });

    test('update user if exist', () async {
      await authLocal.upsertUser(user);

      final updatedUser = user.copyWith(username: 'Someone');

      await authLocal.upsertUser(updatedUser);

      final userDb = await authLocal.usersDao.watchUser('1').first;

      expect(userDb?.username, 'Someone');
    });

    test('stream emits a new user when the name updates', () async {
      await authLocal.upsertUser(user);

      final expectation = expectLater(
        authLocal.usersDao.watchUser(user.id).map((user) => user?.username),
        emitsInOrder(['hasan', 'Someone']),
      );

      await authLocal.upsertUser(user.copyWith(username: 'Someone'));
      await expectation;
    });
  });
}
