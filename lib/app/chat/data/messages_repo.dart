import 'package:chat_mobile/app/auth/data/auth_repo.dart';
import 'package:chat_mobile/app/chat/data/message_remote.dart';
import 'package:chat_mobile/app/chat/domain/conversation_message.dart';
import 'package:chat_mobile/core/services/secure_storage.dart';
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
    String chatId,
    String uid,
    String? originalMessageId,
    String content,
  ) async {
    try {
      final message = await messagesRemote.addMessage(
        uid,
        chatId,
        originalMessageId,
        content,
      );

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
