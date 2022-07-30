import 'dart:developer';

import 'package:chat_mobile/chat/data/chats_repo.dart';
import 'package:chat_mobile/chat/domain/chats_response.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatsController extends StateNotifier<AsyncValue<List<ChatsResponse>>> {
  final ChatsRepo chatsRepo;

  ChatsController({required this.chatsRepo}) : super(const AsyncData([]));

  Future<void> fetchChats() async {
    state = const AsyncLoading();

    final getChats = chatsRepo.getChats;

    state = await AsyncValue.guard(() => getChats());
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

    await fetchChats();
  }
}

final chatsControllerProvider = StateNotifierProvider.autoDispose<
    ChatsController, AsyncValue<List<ChatsResponse>>>((ref) {
  final chatsRepo = ref.watch(chatsRepoProvider);

  return ChatsController(chatsRepo: chatsRepo);
});
