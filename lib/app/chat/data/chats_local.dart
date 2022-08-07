import 'package:chat_mobile/app/chat/domain/chat.dart';
import 'package:chat_mobile/app/chat/domain/conversation.dart';
import 'package:chat_mobile/core/database/dao/chats_dao.dart';
import 'package:chat_mobile/core/database/dao/conversations_dao.dart';
import 'package:chat_mobile/core/database/database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatsLocal {
  final ChatsDao chatsDao;
  final ConversationsDao conversationsDao;

  ChatsLocal({
    required this.chatsDao,
    required this.conversationsDao,
  });

  Future<void> upsertChats(List<Chat> chats) async =>
      await chatsDao.upsertChats(chats);

  Stream<List<Chat>> watchChats(String? currentUserId) =>
      chatsDao.watchChats(currentUserId);

  Future<void> upsertConversation(Conversation conversation) async =>
      await conversationsDao.upsertConversation(conversation);

  Stream<Conversation?> watchConversation(String? chatId) =>
      conversationsDao.watchConversation(chatId);
}

final chatsLocalProvider = Provider((ref) {
  final chatsDao = ref.watch(chatsDaoProvider);
  final conversationsDao = ref.watch(conversationsDaoProvider);

  return ChatsLocal(chatsDao: chatsDao, conversationsDao: conversationsDao);
});
