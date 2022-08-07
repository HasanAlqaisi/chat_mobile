import 'package:chat_mobile/app/auth/data/auth_repo.dart';
import 'package:chat_mobile/app/auth/domain/user.dart';
import 'package:chat_mobile/app/chat/data/chats_repo.dart';
import 'package:chat_mobile/app/chat/domain/chat.dart';
import 'package:chat_mobile/app/chat/domain/conversation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final contentControllerProvider =
    Provider.autoDispose((ref) => TextEditingController());

final usersStreamProvider =
    StreamProvider.family<List<User>, String?>((ref, currentUserId) {
  final authRepo = ref.watch(authRepoProvider);

  return authRepo.watchUsers(currentUserId);
});

final chatsStreamProvider =
    StreamProvider.family<List<Chat>, String?>((ref, currentUserId) {
  final chatsRepo = ref.watch(chatsRepoProvider);

  return chatsRepo.watchChats(currentUserId);
});

final conversationStreamProvider =
    StreamProvider.family<Conversation?, String?>((ref, chatId) {
  final chatsRepo = ref.watch(chatsRepoProvider);

  return chatsRepo.watchConversation(chatId);
});
