import 'dart:convert';
import 'dart:developer' show log;

import 'package:chat_mobile/utils/errors/exceptions.dart';
import 'package:chat_mobile/utils/services/http.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatsRemote {
  final DioClient dioClient;

  ChatsRemote({required this.dioClient});

  Future<void> deleteChat(String chatId) async {
    try {
      final res = await dioClient.dio.delete('/chats/$chatId',
          options: Options(headers: {'requireToken': true}));

      log("result ${res.data}", name: 'chats_remote.dart:deleteChat');
    } on DioError catch (error) {
      log("Error $error", name: 'chats_remote.dart:deleteChat');

      switch (error.type) {
        case DioErrorType.connectTimeout:
          throw ApiTimeoutException();
        case DioErrorType.sendTimeout:
          throw ApiTimeoutException();
        case DioErrorType.receiveTimeout:
          throw ApiTimeoutException();
        case DioErrorType.response:
          if (error.response?.statusCode == 401) {
            throw UserNotAuthedException();
          }

          throw ApiResponseException(
            body: jsonDecode(error.response?.data),
            type: jsonDecode(error.response?.data)['_type'],
          );
        case DioErrorType.cancel:
          throw ApiCancelException();
        case DioErrorType.other:
          throw ApiUnkownException();
      }
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
