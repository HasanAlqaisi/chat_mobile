import 'package:chat_mobile/chat/data/chats_remote.dart';
import 'package:chat_mobile/chat/domain/chats_response.dart';
import 'package:chat_mobile/chat/domain/conversation_response.dart';
import 'package:chat_mobile/utils/constants/secrets.dart';
import 'package:chat_mobile/utils/errors/data_or_failure.dart';
import 'package:chat_mobile/utils/errors/exceptions.dart';
import 'package:chat_mobile/utils/errors/failures.dart';
import 'package:chat_mobile/utils/errors/handle_response_exception.dart';
import 'package:chat_mobile/utils/storage/secure_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jwt_decode/jwt_decode.dart';

class ChatsRepo {
  final ChatsRemote chatsRemote;
  final SecureStorage secureStorage;

  ChatsRepo({
    required this.chatsRemote,
    required this.secureStorage,
  });

  Future<DataOrFailure<List<ChatsResponse>, Failure>> getChats() async {
    try {
      final token = await secureStorage.readToken(Secrets.tokenKey);

      if (token != null) {
        final decodedToken = Jwt.parseJwt(token);

        final chats = await chatsRemote.getChats(decodedToken['id']);

        return DataOrFailure(data: chats);
      } else {
        throw UserNotAuthedException();
      }
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

  Future<DataOrFailure<ConversationResponse, Failure>> getChat(String chatId) async {
    try {
      final chat = await chatsRemote.getChat(chatId);

      return DataOrFailure(data: chat);
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

final chatsRepoProvider = Provider<ChatsRepo>((ref) {
  final chatsRemote = ref.watch(chatsRemoteProvider);
  final appSecureStorage = ref.watch(appSecureStorageProvider);

  return ChatsRepo(chatsRemote: chatsRemote, secureStorage: appSecureStorage);
});
