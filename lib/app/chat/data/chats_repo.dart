import 'package:chat_mobile/app/auth/data/auth_repo.dart';
import 'package:chat_mobile/app/chat/data/chats_local.dart';
import 'package:chat_mobile/app/chat/data/chats_remote.dart';
import 'package:chat_mobile/app/chat/domain/chat.dart';
import 'package:chat_mobile/app/chat/domain/conversation.dart';
import 'package:chat_mobile/core/services/secure_storage.dart';
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

      await chatsLocal.upsertChats(chats);

      return chats;
    } catch (_) {
      rethrow;
    }
  }

  Future<Conversation> getConversation(String chatId) async {
    try {
      final chat = await chatsRemote.getConversation(chatId);

      await chatsLocal.upsertConversation(chat);

      return chat;
    } catch (_) {
      rethrow;
    }
  }

  Future<void> deleteConversation(String chatId) async {
    try {
      await chatsRemote.deleteConversation(chatId);
    } catch (_) {
      rethrow;
    }
  }

  Future<void> approveConversation(String chatId) async {
    try {
      await chatsRemote.approveConversation(chatId);
    } catch (_) {
      rethrow;
    }
  }

  Stream<List<Chat>> watchChats(String? currentUserId) =>
      chatsLocal.watchChats(currentUserId);

  Stream<Conversation?> watchConversation(String? chatId) =>
      chatsLocal.watchConversation(chatId);
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
