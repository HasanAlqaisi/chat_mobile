import 'package:chat_mobile/app/chat/data/chats_repo.dart';
import 'package:chat_mobile/app/chat/domain/chat.dart';
import 'package:chat_mobile/app/chat/presentation/providers/chats_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockChatsRepo extends Mock implements ChatsRepo {
  @override
  Future<List<Chat>> getChats(String uid, String? query) {
    // throw exception;
    return Future.value(<Chat>[]);
  }
}

class MockChatsController extends StateNotifier<AsyncValue<List<Chat>>>
    with Mock
    implements ChatsController {
  final ChatsRepo repo;

  MockChatsController({required this.repo}) : super(const AsyncData(<Chat>[]));

  @override
  Future<void> fetchChats(String uid, String? query) {
    return repo.getChats('', '');
  }
}

class Listener<T> extends Mock {
  void call(T? old, T current);
}

void main() {
  late ProviderContainer container;
  late Listener listener;
  late ChatsController controller;
  late ChatsRepo repo;

  setUp(() {
    container = ProviderContainer();
    listener = Listener<AsyncValue<List<Chat>>>();
    repo = MockChatsRepo();
    controller = MockChatsController(repo: repo);
  });

  group('fetchChats', () {
    test('initial state is empty list', () {
      container.listen(chatsControllerProvider, listener,
          fireImmediately: true);

      verify(listener(null, const AsyncData(<Chat>[]))).called(1);
    });

    test('state is list of chat after successfull operation', () async {
      container.listen(chatsControllerProvider, listener,
          fireImmediately: true);

      await controller.fetchChats('', '');

      await container.pump();

      verify(listener(null, const AsyncData(<Chat>[]))).called(1);
    });
  });
}
