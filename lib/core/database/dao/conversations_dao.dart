import 'package:chat_mobile/app/chat/domain/conversation.dart';
import 'package:chat_mobile/core/database/database.dart';
import 'package:chat_mobile/core/database/tables.dart';
import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'conversations_dao.g.dart';

@DriftAccessor(tables: [Conversations])
class ConversationsDao extends DatabaseAccessor<AppDatabase>
    with _$ConversationsDaoMixin {
  ConversationsDao(AppDatabase db) : super(db);

  Future<void> upsertConversation(
    Conversation conversation,
  ) async {
    final companionConversation = ConversationsCompanion.insert(
      chatId: conversation.chatId,
      userId: conversation.userId,
      username: conversation.username,
      receiverApprove: conversation.receiverApprove,
      isRequesterSender: conversation.isRequesterSender,
      messages: conversation.messages,
    );

    await batch((batch) {
      batch.deleteWhere(conversations, (row) => const Constant(true));

      batch.insert(conversations, companionConversation);
    });
  }

  Stream<Conversation?> watchConversation(String? chatId) {
    return (select(conversations)
          ..where((conversation) => conversation.chatId.equals(chatId)))
        .watchSingleOrNull();
  }
}

final conversationsDaoProvider = Provider((ref) {
  final db = ref.watch(appDatabaseProvider);

  return ConversationsDao(db);
});
