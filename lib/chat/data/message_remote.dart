import 'package:chat_mobile/chat/domain/conversation_message.dart';
import 'package:chat_mobile/utils/services/http.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MessagesRemote {
  final DioClient dioClient;

  MessagesRemote({required this.dioClient});

  Future<ConversationMessage> addMessage(
    String userId,
    String chatId,
    String? originalMessageId,
    String content,
  ) async {
    final res = await dioClient.dio.post('/messages',
        data: {
          'userId': userId,
          'chatId': chatId,
          'ori': userId,
          'content': content,
        },
        options: Options(headers: {'requireToken': true}));

    return ConversationMessage.fromMap(res.data as Map<String, dynamic>);
  }
}

final messagesRemoteProvider = Provider<MessagesRemote>(((ref) {
  final dioClient = ref.watch(dioProvider);

  return MessagesRemote(dioClient: dioClient);
}));
