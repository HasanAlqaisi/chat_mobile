import 'package:chat_mobile/auth/data/auth_repo.dart';
import 'package:chat_mobile/chat/data/message_remote.dart';
import 'package:chat_mobile/chat/domain/conversation_message.dart';
import 'package:chat_mobile/utils/storage/secure_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MessagesRepo {
  final MessagesRemote messagesRemote;
  final SecureStorage secureStorage;
  final AuthRepo authRepo;

  MessagesRepo({
    required this.messagesRemote,
    required this.secureStorage,
    required this.authRepo,
  });

  Future<ConversationMessage> addMessage(
      String chatId, String? originalMessageId, String content) async {
    try {
      final uid = await authRepo.getUserId;

      final message = await messagesRemote.addMessage(
          uid, chatId, originalMessageId, content);

      return message;
    } catch (e) {
      rethrow;
    }
  }
}

final messagesRepoProvider = Provider<MessagesRepo>((ref) {
  final messagesRemote = ref.watch(messagesRemoteProvider);
  final appSecureStorage = ref.watch(appSecureStorageProvider);
  final authRepo = ref.watch(authRepoProvider);

  return MessagesRepo(
    messagesRemote: messagesRemote,
    secureStorage: appSecureStorage,
    authRepo: authRepo,
  );
});
