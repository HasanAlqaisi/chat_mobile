import 'package:chat_mobile/repos/chats/chats_repo.dart';
import 'package:chat_mobile/utils/errors/data_or_failure.dart';
import 'package:chat_mobile/utils/errors/failures.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final deleteChatProvider = FutureProvider.family
    .autoDispose<DataOrFailure<void, Failure>, String>((ref, id) async {
  final chatRepo = ref.watch(chatsRepoProvider);

  return await chatRepo.deleteChat(id);
});
