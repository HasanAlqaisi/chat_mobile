import 'dart:developer' show log;

import 'package:chat_mobile/chat/domain/chats_response.dart';
import 'package:chat_mobile/chat/domain/conversation_response.dart';
import 'package:chat_mobile/utils/errors/exceptions.dart';
import 'package:chat_mobile/utils/services/http.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatsRemote {
  final DioClient dioClient;

  ChatsRemote({required this.dioClient});

  Future<List<ChatsResponse>> getChats(String userId) async {
    try {
      final res = await dioClient.dio.get('/chats/user/$userId',
          options: Options(headers: {'requireToken': true}));

      log("result ${res.data}", name: 'chats_remote.dart:getChats');

      return (res.data as List)
          .map(
            (chat) => ChatsResponse.fromMap(chat as Map<String, dynamic>),
          )
          .toList();
    } catch (error) {
      log("Error $error", name: 'chats_remote.dart:getChats');
      throw ApiUnkownException();
    }
  }

  Future<ConversationResponse> getChat(String chatId) async {
    try {
      final res = await dioClient.dio.get('/chats/$chatId/messages',
          options: Options(headers: {'requireToken': true}));

      log("result ${res.data}", name: 'chats_remote.dart:getChats');

      return ConversationResponse.fromMap(res.data as Map<String, dynamic>);
    } catch (error) {
      log("Error $error", name: 'chats_remote.dart:getChats');
      throw ApiUnkownException();
    }
  }

  Future<void> deleteChat(String chatId) async {
    try {
      final res = await dioClient.dio.delete('/chats/$chatId',
          options: Options(headers: {'requireToken': true}));

      log("result ${res.data}", name: 'chats_remote.dart:deleteChat');
    } catch (error) {
      log("Error $error", name: 'chats_remote.dart:deleteCha');
      throw ApiUnkownException();
    }
  }
}

final chatsRemoteProvider = Provider<ChatsRemote>(((ref) {
  final dioClient = ref.watch(dioProvider);

  return ChatsRemote(dioClient: dioClient);
}));
