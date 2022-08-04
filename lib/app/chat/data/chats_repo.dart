import 'package:chat_mobile/app/auth/data/auth_repo.dart';
import 'package:chat_mobile/app/chat/data/chats_local.dart';
import 'package:chat_mobile/app/chat/data/chats_remote.dart';
import 'package:chat_mobile/app/chat/domain/chat.dart';
import 'package:chat_mobile/app/chat/domain/conversation.dart';
import 'package:chat_mobile/core/database/database.dart';
import 'package:chat_mobile/core/services/secure_storage.dart';
import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatsRepo {
  final ChatsRemote chatsRemote;
  final ChatsLocal chatsLocal;
  final SecureStorage secureStorage;
  final AuthRepo authRepo;

  ChatsRepo({
    required this.chatsRemote,
    required this.chatsLocal,
    required this.secureStorage,
    required this.authRepo,
  });

  Future<void> createChat(String senderId, receiverId) async {
    try {
      await chatsRemote.createChat(senderId, receiverId);
    } catch (_) {
      rethrow;
    }
  }

  Future<List<Chat>> getChats(String uid, String? query) async {
    try {
      final chats = await chatsRemote.getChats(uid, query);

      final insertableChats = chats
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

      await chatsLocal.upsertChats(insertableChats);

      return chats;
    } catch (_) {
      rethrow;
    }
  }

  Future<Conversation> getChat(String chatId) async {
    try {
      final chat = await chatsRemote.getChat(chatId);

      final insertableConversation = ConversationsCompanion.insert(
        chatId: chat.chatId,
        userId: chat.userId,
        username: chat.username,
        receiverApprove: chat.receiverApprove,
        isRequesterSender: chat.isRequesterSender,
        messages: chat.messages,
      );

      await chatsLocal.upsertConversation(insertableConversation);

      return chat;
    } catch (_) {
      rethrow;
    }
  }

  Future<void> deleteChat(String chatId) async {
    try {
      await chatsRemote.deleteChat(chatId);
    } catch (_) {
      rethrow;
    }
  }

  Future<void> approveChat(String chatId) async {
    try {
      await chatsRemote.approveChat(chatId);
    } catch (_) {
      rethrow;
    }
  }

  Stream<List<Chat>> watchChats(String? currentUserId) =>
      chatsLocal.watchChats(currentUserId);

  Stream<Conversation?> watchConversations(String? chatId) =>
      chatsLocal.watchConversations(chatId);
}

final chatsRepoProvider = Provider<ChatsRepo>((ref) {
  final chatsRemote = ref.watch(chatsRemoteProvider);
  final chatsLocal = ref.watch(chatsLocalProvider);
  final appSecureStorage = ref.watch(appSecureStorageProvider);
  final authRepo = ref.watch(authRepoProvider);

  return ChatsRepo(
    chatsRemote: chatsRemote,
    chatsLocal: chatsLocal,
    secureStorage: appSecureStorage,
    authRepo: authRepo,
  );
});
