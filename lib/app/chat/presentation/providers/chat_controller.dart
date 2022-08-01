import 'package:chat_mobile/app/chat/data/chats_repo.dart';
import 'package:chat_mobile/app/chat/data/messages_repo.dart';
import 'package:chat_mobile/app/chat/domain/conversation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatController extends StateNotifier<AsyncValue<Conversation?>> {
  final ChatsRepo chatsRepo;
  final MessagesRepo messagesRepo;

  ChatController({
    required this.chatsRepo,
    required this.messagesRepo,
  }) : super(const AsyncData(null));

  Future<void> fetchChat(String chatId) async {
    state = const AsyncLoading();

    final getChat = chatsRepo.getChat;

    state = await AsyncValue.guard(() => getChat(chatId));
  }

  Future<void> _addMessage(
    String chatId,
    String uid,
    String? originalMessageId,
    String content,
  ) async {
    final addMessage = messagesRepo.addMessage;

    await AsyncValue.guard(() => addMessage(
          chatId,
          uid,
          originalMessageId,
          content,
        ));
  }

  Future<void> fetchMessages(
    String chatId,
    String uid,
    String? originalMessageId,
    String content,
  ) async {
    await _addMessage(chatId, uid, originalMessageId, content);

    final getChat = chatsRepo.getChat;

    state = await AsyncValue.guard(() => getChat(chatId));
  }

  Future<void> approveChat(String chatId) async {
    state = const AsyncLoading();

    final approveChat = chatsRepo.approveChat;

    await AsyncValue.guard(() => approveChat(chatId));

    await fetchChat(chatId);
  }
}

final chatControllerProvider = StateNotifierProvider.autoDispose<ChatController,
    AsyncValue<Conversation?>>((ref) {
  final chatsRepo = ref.watch(chatsRepoProvider);
  final messagesRepo = ref.watch(messagesRepoProvider);

  return ChatController(chatsRepo: chatsRepo, messagesRepo: messagesRepo);
});
