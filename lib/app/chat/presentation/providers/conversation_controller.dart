import 'package:chat_mobile/app/chat/data/chats_repo.dart';
import 'package:chat_mobile/app/chat/domain/conversation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ConversationController extends StateNotifier<AsyncValue<Conversation?>> {
  final ChatsRepo chatsRepo;

  ConversationController({required this.chatsRepo})
      : super(const AsyncData(null));

  Future<void> fetchConversation(String chatId) async {
    state = const AsyncLoading();

    final getChat = chatsRepo.getConversation;

    state = await AsyncValue.guard(() => getChat(chatId));
  }

  Future<void> approveChat(String chatId) async {
    state = const AsyncLoading();

    final approveChat = chatsRepo.approveConversation;

    await AsyncValue.guard(() => approveChat(chatId));

    await fetchConversation(chatId);
  }
}

final conversationControllerProvider = StateNotifierProvider.autoDispose<
    ConversationController, AsyncValue<Conversation?>>((ref) {
  final chatsRepo = ref.watch(chatsRepoProvider);

  return ConversationController(chatsRepo: chatsRepo);
});
