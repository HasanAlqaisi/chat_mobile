import 'package:chat_mobile/app/chat/domain/chat.dart';
import 'package:chat_mobile/core/database/dao/chats_dao.dart';
import 'package:chat_mobile/core/database/database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatsLocal {
  final ChatsDao chatsDao;

  ChatsLocal({required this.chatsDao});

  Future<void> upsertChats(List<ChatsCompanion> chats) async =>
      await chatsDao.upsertChats(chats);

  Stream<List<Chat>> watchChats(String? currentUserId) =>
      chatsDao.watchChats(currentUserId);
}

final chatsLocalProvider = Provider((ref) {
  final chatsDao = ref.watch(chatsDaoProvider);

  return ChatsLocal(chatsDao: chatsDao);
});
