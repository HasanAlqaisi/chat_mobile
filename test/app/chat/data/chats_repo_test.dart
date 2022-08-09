import 'package:chat_mobile/app/auth/data/auth_repo.dart';
import 'package:chat_mobile/app/chat/data/chats_local.dart';
import 'package:chat_mobile/app/chat/data/chats_remote.dart';
import 'package:chat_mobile/app/chat/data/chats_repo.dart';
import 'package:chat_mobile/app/chat/domain/chat.dart';
import 'package:chat_mobile/core/services/secure_storage.dart';
import 'package:chat_mobile/utils/errors/exceptions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'chats_repo_test.mocks.dart';

@GenerateMocks([ChatsRemote, ChatsLocal, AppSecureStorage, AuthRepo])
void main() {
  late ProviderContainer container;
  late ChatsRemote chatsRemote;
  late ChatsLocal chatsLocal;
  late SecureStorage secureStorage;
  late AuthRepo authRepo;
  late ChatsRepo repo;

  setUp(() {
    container = ProviderContainer(overrides: [
      chatsRemoteProvider.overrideWithValue(MockChatsRemote()),
      chatsLocalProvider.overrideWithValue(MockChatsLocal()),
      appSecureStorageProvider.overrideWithValue(MockAppSecureStorage()),
      authRepoProvider.overrideWithValue(MockAuthRepo())
    ]);

    chatsRemote = container.read(chatsRemoteProvider);
    chatsLocal = container.read(chatsLocalProvider);
    secureStorage = container.read(appSecureStorageProvider);
    authRepo = container.read(authRepoProvider);

    repo = ChatsRepo(
      chatsRemote: chatsRemote,
      chatsLocal: chatsLocal,
      secureStorage: secureStorage,
      authRepo: authRepo,
    );
  });

  group('getChats', () {
    setUp(() {
      when(chatsRemote.getChats('', '')).thenAnswer((_) async => <Chat>[]);

      when(chatsLocal.upsertChats(<Chat>[])).thenAnswer((_) async {});
    });

    test('Get data from chats Api', () async {
      await repo.getChats('', '');

      verify(chatsRemote.getChats('', '')).called(1);
    });

    test('Save chats result from api in the database', () async {
      await repo.getChats('', '');

      verify(chatsLocal.upsertChats(<Chat>[])).called(1);
    });

    test('return chats is successed', () async {
      await repo.getChats('', '');

      expect(await repo.getChats('', ''), isA<List<Chat>>());
    });

    test('throw exception if api call fail', () async {
      when(chatsRemote.getChats('', ''))
          .thenThrow(ApiResponseException(type: '_SIMPLE'));

      expect(() async => await repo.getChats('', ''),
          throwsA(isA<ApiResponseException>()));
    });

    test('throw exception if insertion to database fail', () async {
      when(chatsLocal.upsertChats(<Chat>[])).thenThrow(Exception());

      expect(
          () async => await repo.getChats('', ''), throwsA(isA<Exception>()));
    });
  });
}
