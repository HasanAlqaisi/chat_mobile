import 'package:chat_mobile/app/chat/domain/chat.dart';
import 'package:chat_mobile/core/database/database.dart';
import 'package:chat_mobile/core/database/tables.dart';
import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'chats_dao.g.dart';

@DriftAccessor(tables: [Chats])
class ChatsDao extends DatabaseAccessor<AppDatabase> with _$ChatsDaoMixin {
  ChatsDao(AppDatabase db) : super(db);

  Future<void> upsertChats(List<Chat> chatsList) async {
    final companionChats = chatsList
        .map((chat) => ChatsCompanion.insert(
              chatId: chat.chatId,
              userId: chat.userId,
              receiverApprove: chat.receiverApprove,
              username: chat.username,
              userImage: Value(chat.userImage),
              countNewMessages: chat.countNewMessages,
              latestMessage: Value(chat.latestMessage),
            ))
        .toList();

    await batch((batch) {
      batch.deleteWhere(chats, (row) => const Constant(true));

      batch.insertAllOnConflictUpdate(chats, companionChats);
    });
  }

  Stream<List<Chat>> watchChats(String? currentUserId) {
    return (select(chats)..where((chat) => chat.userId.equals(currentUserId)))
        .watch();
  }
}

final chatsDaoProvider = Provider((ref) {
  final db = ref.watch(appDatabaseProvider);

  return ChatsDao(db);
});
