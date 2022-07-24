import 'dart:developer' show log;

import 'package:chat_mobile/data/models/conversation_response.dart';
import 'package:chat_mobile/utils/errors/exceptions.dart';
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
    try {
      final res = await dioClient.dio.post('/messages',
          data: {
            'userId': userId,
            'chatId': chatId,
            'ori': userId,
            'content': content,
          },
          options: Options(headers: {'requireToken': true}));

      log("result ${res.data}", name: 'messages_remote.dart:addMessage');

      return ConversationMessage.fromMap(res.data as Map<String, dynamic>);
    } catch (error) {
      log("Error $error", name: 'messages_remote.dart:addMessage');
      throw ApiUnkownException();
    }
  }
}

final messagesRemoteProvider = Provider<MessagesRemote>(((ref) {
  final dioClient = ref.watch(dioProvider);

  return MessagesRemote(dioClient: dioClient);
}));
