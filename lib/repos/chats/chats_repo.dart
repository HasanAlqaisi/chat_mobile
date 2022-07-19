import 'package:chat_mobile/data/services/chats/chats_remote.dart';
import 'package:chat_mobile/utils/errors/data_or_failure.dart';
import 'package:chat_mobile/utils/errors/exceptions.dart';
import 'package:chat_mobile/utils/errors/failures.dart';
import 'package:chat_mobile/utils/errors/handle_response_errors.dart';
import 'package:chat_mobile/utils/storage/secure_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatsRepo {
  final ChatsRemote chatsRemote;
  final SecureStorage secureStorage;

  ChatsRepo({
    required this.chatsRemote,
    required this.secureStorage,
  });

  Future<DataOrFailure<void, Failure>> deleteChat(
    String chatId,
  ) async {
    try {
      await chatsRemote.deleteChat(chatId);
      return DataOrFailure();
    } on UserNotAuthedException catch (_) {
      return DataOrFailure(failure: UserNotAuthedFailure());
    } on ApiTimeoutException catch (_) {
      return DataOrFailure(failure: ApiTimeoutFailure());
    } on ApiResponseException catch (error) {
      return DataOrFailure(failure: handleResponseErrors(error));
    } on ApiCancelException catch (_) {
      return DataOrFailure(failure: ApiCancelFailure());
    } on ApiUnkownException catch (_) {
      return DataOrFailure(failure: ApiUnkownFailure());
    } catch (e) {
      return DataOrFailure(failure: ApiUnkownFailure());
    }
  }
}

final chatsRepoProvider = Provider<ChatsRepo>((ref) {
  final chatsRemote = ref.watch(chatsRemoteProvider);
  final appSecureStorage = ref.watch(appSecureStorageProvider);

  return ChatsRepo(chatsRemote: chatsRemote, secureStorage: appSecureStorage);
});
