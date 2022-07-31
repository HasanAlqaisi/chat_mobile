import 'package:chat_mobile/app/chat/data/chats_repo.dart';
import 'package:chat_mobile/app/chat/domain/chats_response.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatsController extends StateNotifier<AsyncValue<List<ChatsResponse>>> {
  final ChatsRepo chatsRepo;

  ChatsController({required this.chatsRepo}) : super(const AsyncData([]));

  Future<void> fetchChats(String uid) async {
    state = const AsyncLoading();

    final getChats = chatsRepo.getChats;

    state = await AsyncValue.guard(() => getChats(uid));
  }

  Future<void> createChat(
    String senderId,
    String receiverId,
  ) async {
    state = const AsyncLoading();

    final createChat = chatsRepo.createChat;

    final res = await AsyncValue.guard(() => createChat(senderId, receiverId));

    if (res is AsyncError) {
      state = AsyncError(res.error);
      return;
    }

    await fetchChats(senderId);
  }
}

final chatsControllerProvider = StateNotifierProvider.autoDispose<
    ChatsController, AsyncValue<List<ChatsResponse>>>((ref) {
  final chatsRepo = ref.watch(chatsRepoProvider);

  return ChatsController(chatsRepo: chatsRepo);
});
