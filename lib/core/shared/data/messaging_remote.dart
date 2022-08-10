import 'package:chat_mobile/core/network/dio_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MessagingRemote {
  final DioClient dioClient;

  MessagingRemote({required this.dioClient});

  Future<void> sendMessagingToken(String userId, String token) async {
    await dioClient.dio.post(
      '/tokens/',
      options: Options(headers: {'requireToken': true}),
      data: {'userId': userId, 'token': token},
    );
  }
}

final messagingRemoteProvider = Provider((ref) {
  final dioClient = ref.watch(dioClientProvider);

  return MessagingRemote(dioClient: dioClient);
});
