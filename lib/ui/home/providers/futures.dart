import 'package:chat_mobile/data/models/conversation_response.dart';
import 'package:chat_mobile/data/models/chats_response.dart';
import 'package:chat_mobile/repos/chats/chats_repo.dart';
import 'package:chat_mobile/utils/constants/secrets.dart';
import 'package:chat_mobile/utils/errors/data_or_failure.dart';
import 'package:chat_mobile/utils/errors/failures.dart';
import 'package:chat_mobile/utils/extensions/jwt.dart';
import 'package:chat_mobile/utils/storage/secure_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jwt_decode/jwt_decode.dart';

final getChatsProvider =
    FutureProvider.autoDispose<DataOrFailure<List<ChatsResponse>, Failure>>(
        (ref) async {
  final chatRepo = ref.watch(chatsRepoProvider);

  return await chatRepo.getChats();
});

final getChatProvider = FutureProvider.family
    .autoDispose<DataOrFailure<ConversationResponse, Failure>, String>(
        (ref, chatId) async {
  final chatRepo = ref.watch(chatsRepoProvider);

  return await chatRepo.getChat(chatId);
});

final getCurrentUserIdProvider = FutureProvider<String>((ref) async {
  final appSecureStorage = ref.watch(appSecureStorageProvider);

  final token = await appSecureStorage.readToken(Secrets.tokenKey);

  final id = JwtExtension.getUserId(token);

  return id;
});

final deleteChatProvider = FutureProvider.family
    .autoDispose<DataOrFailure<void, Failure>, String>((ref, id) async {
  final chatRepo = ref.watch(chatsRepoProvider);

  return await chatRepo.deleteChat(id);
});