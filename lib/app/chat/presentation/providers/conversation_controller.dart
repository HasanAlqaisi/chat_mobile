import 'package:chat_mobile/app/chat/data/chats_repo.dart';
import 'package:chat_mobile/app/chat/data/messages_repo.dart';
import 'package:chat_mobile/app/chat/domain/conversation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ConversationController extends StateNotifier<AsyncValue<Conversation?>> {
  final ChatsRepo chatsRepo;
  final MessagesRepo messagesRepo;

  ConversationController({
    required this.chatsRepo,
    required this.messagesRepo,
  }) : super(const AsyncData(null));

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
  final messagesRepo = ref.watch(messagesRepoProvider);

  return ConversationController(
      chatsRepo: chatsRepo, messagesRepo: messagesRepo);
});
