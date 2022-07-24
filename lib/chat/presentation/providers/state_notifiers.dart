import 'package:chat_mobile/chat/data/chats_repo.dart';
import 'package:chat_mobile/chat/data/messages_repo.dart';
import 'package:chat_mobile/chat/domain/conversation_response.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatStateNotifier extends StateNotifier<ConversationResponse?> {
  final ChatsRepo chatsRepo;
  final MessagesRepo messagesRepo;

  ChatStateNotifier({
    required this.chatsRepo,
    required this.messagesRepo,
  }) : super(null);

  Future<void> fetchChat(String chatId) async {
    final chat = await chatsRepo.getChat(chatId);

    state = chat.data;
  }

  void addMessage(
    String chatId,
    String? originalMessageId,
    String content,
  ) async {
    final message = await messagesRepo.addMessage(
      chatId,
      originalMessageId,
      content,
    );

    state = state?.copyWith(messages: [...state!.messages, message.data!]);
  }
}

final chatStateNotifierProvider =
    StateNotifierProvider.autoDispose<ChatStateNotifier, ConversationResponse?>((ref) {
  final chatsRepo = ref.watch(chatsRepoProvider);
  final messagesRepo = ref.watch(messagesRepoProvider);

  return ChatStateNotifier(chatsRepo: chatsRepo, messagesRepo: messagesRepo);
});
