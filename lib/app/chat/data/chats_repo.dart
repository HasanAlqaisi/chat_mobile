import 'package:chat_mobile/app/auth/data/auth_repo.dart';
import 'package:chat_mobile/app/chat/data/chats_remote.dart';
import 'package:chat_mobile/app/chat/domain/chats_response.dart';
import 'package:chat_mobile/app/chat/domain/conversation_response.dart';
import 'package:chat_mobile/core/services/secure_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatsRepo {
  final ChatsRemote chatsRemote;
  final SecureStorage secureStorage;
  final AuthRepo authRepo;

  ChatsRepo({
    required this.chatsRemote,
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

  Future<List<ChatsResponse>> getChats(String uid) async {
    try {
      final chats = await chatsRemote.getChats(uid);

      return chats;
    } catch (_) {
      rethrow;
    }
  }

  Future<ConversationResponse> getChat(String chatId) async {
    try {
      final chat = await chatsRemote.getChat(chatId);

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
}

final chatsRepoProvider = Provider<ChatsRepo>((ref) {
  final chatsRemote = ref.watch(chatsRemoteProvider);
  final appSecureStorage = ref.watch(appSecureStorageProvider);
  final authRepo = ref.watch(authRepoProvider);

  return ChatsRepo(
    chatsRemote: chatsRemote,
    secureStorage: appSecureStorage,
    authRepo: authRepo,
  );
});
