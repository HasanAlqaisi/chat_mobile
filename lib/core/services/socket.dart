import 'dart:developer';

import 'package:chat_mobile/app/chat/presentation/providers/chat_controller.dart';
import 'package:chat_mobile/core/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socket_io_client/socket_io_client.dart';

class ChatSocket {
  final Socket socket;
  final Ref ref;

  ChatSocket({
    required this.ref,
    required this.socket,
  });

  void onConnect() {
    socket.on('connect', (data) {
      log('is connected? ${socket.connected}', name: 'socket');
    });
  }

  void emitOnChat(String userId) {
    socket.emit('chat', userId);
  }

  void onMessage({
    required String currentUserId,
    required String chatId,
  }) {
    socket.on('message', (data) {
      log('this is the message: $data', name: 'message through socket');

      if (data['senderId'] == currentUserId ||
          data['receiverId'] == currentUserId) {
        log('fetching chat...');
        ref.read(chatControllerProvider.notifier).fetchChat(chatId);
      }
    });
  }

  void emitOnMessage({
    String? originalMessageId,
    required String currentUserId,
    required String chatId,
    required String content,
  }) {
    if (originalMessageId != null) {
      socket.emit('message', {
        "originalMessageId": originalMessageId,
        "userId": currentUserId,
        "chatId": chatId,
        "content": content,
      });
    } else {
      socket.emit('message', {
        "userId": currentUserId,
        "chatId": chatId,
        "content": content,
      });
    }
  }
}

final chatSocketProvider = Provider.autoDispose((ref) {
  final socket = ref.watch(socketProvider);

  return ChatSocket(ref: ref, socket: socket);
});
