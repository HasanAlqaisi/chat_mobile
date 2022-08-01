import 'package:chat_mobile/app/chat/domain/chat.dart';
import 'package:chat_mobile/app/chat/domain/conversation.dart';
import 'package:chat_mobile/core/network/dio_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatsRemote {
  final DioClient dioClient;

  ChatsRemote({required this.dioClient});

  Future<void> createChat(
    String senderId,
    String receiverId,
  ) async {
    await dioClient.dio.post(
      '/chats/',
      options: Options(headers: {'requireToken': true}),
      data: {
        "senderId": senderId,
        "receiverId": receiverId,
      },
    );
  }

  Future<List<Chat>> getChats(String userId) async {
    final res = await dioClient.dio.get('/chats/user/$userId',
        options: Options(headers: {'requireToken': true}));

    return (res.data as List)
        .map(
          (chat) => Chat.fromMap(chat as Map<String, dynamic>),
        )
        .toList();
  }

  Future<Conversation> getChat(String chatId) async {
    final res = await dioClient.dio.get('/chats/$chatId/messages',
        options: Options(headers: {'requireToken': true}));

    return Conversation.fromMap(res.data as Map<String, dynamic>);
  }

  Future<void> deleteChat(String chatId) async {
    await dioClient.dio.delete('/chats/$chatId',
        options: Options(headers: {'requireToken': true}));
  }

  Future<void> approveChat(String chatId) async {
    await dioClient.dio.patch(
      '/chats/approve/$chatId',
      options: Options(headers: {'requireToken': true}),
    );
  }
}

final chatsRemoteProvider = Provider<ChatsRemote>(((ref) {
  final dioClient = ref.watch(dioProvider);

  return ChatsRemote(dioClient: dioClient);
}));
