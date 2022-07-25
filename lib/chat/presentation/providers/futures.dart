import 'package:chat_mobile/chat/data/chats_repo.dart';
import 'package:chat_mobile/chat/domain/chats_response.dart';
import 'package:chat_mobile/chat/domain/conversation_response.dart';
import 'package:chat_mobile/utils/errors/data_or_failure.dart';
import 'package:chat_mobile/utils/errors/failures.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getChatsProvider =
    FutureProvider.autoDispose<DataOrFailure<List<ChatsResponse>, Failure>>(
        (ref) async {
  final chatRepo = ref.watch(chatsRepoProvider);

  return await chatRepo.getChats();
});

final getChatProvider = FutureProvider.family
    .autoDispose<DataOrFailure<ConversationResponse, Failure>, String>(
        (ref, chatId) async {
  final chatRepo = ref.watch(chatsRepoProvider);

  return await chatRepo.getChat(chatId);
});

final deleteChatProvider = FutureProvider.family
    .autoDispose<DataOrFailure<void, Failure>, String>((ref, id) async {
  final chatRepo = ref.watch(chatsRepoProvider);

  return await chatRepo.deleteChat(id);
});
