import 'package:chat_mobile/chat/data/message_remote.dart';
import 'package:chat_mobile/chat/domain/conversation_response.dart';
import 'package:chat_mobile/utils/constants/secrets.dart';
import 'package:chat_mobile/utils/errors/data_or_failure.dart';
import 'package:chat_mobile/utils/errors/exceptions.dart';
import 'package:chat_mobile/utils/errors/failures.dart';
import 'package:chat_mobile/utils/errors/handle_response_exception.dart';
import 'package:chat_mobile/utils/storage/secure_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jwt_decode/jwt_decode.dart';

class MessagesRepo {
  final MessagesRemote messagesRemote;
  final SecureStorage secureStorage;

  MessagesRepo({
    required this.messagesRemote,
    required this.secureStorage,
  });

  Future<DataOrFailure<ConversationMessage, Failure>> addMessage(
    String chatId,
    String? originalMessageId,
    String content,
  ) async {
    try {
      final token = await secureStorage.readToken(Secrets.tokenKey);

      final decodedToken = Jwt.parseJwt(token!);

      final message = await messagesRemote.addMessage(
        decodedToken['id'],
        chatId,
        originalMessageId,
        content,
      );

      return DataOrFailure(data: message);
    } on UserNotAuthedException catch (_) {
      return DataOrFailure(failure: UserNotAuthedFailure());
    } on ApiTimeoutException catch (_) {
      return DataOrFailure(failure: ApiTimeoutFailure());
    } on ApiResponseException catch (error) {
      return DataOrFailure(failure: handleResponseException(error));
    } on ApiCancelException catch (_) {
      return DataOrFailure(failure: ApiCancelFailure());
    } on ApiUnkownException catch (_) {
      return DataOrFailure(failure: ApiUnkownFailure());
    } catch (e) {
      return DataOrFailure(failure: ApiUnkownFailure());
    }
  }
}

final messagesRepoProvider = Provider<MessagesRepo>((ref) {
  final messagesRemote = ref.watch(messagesRemoteProvider);
  final appSecureStorage = ref.watch(appSecureStorageProvider);

  return MessagesRepo(
      messagesRemote: messagesRemote, secureStorage: appSecureStorage);
});
