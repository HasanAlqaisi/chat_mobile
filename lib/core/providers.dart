import 'package:chat_mobile/app/auth/data/auth_repo.dart';
import 'package:chat_mobile/utils/extensions/jwt_extension.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socket_io_client/socket_io_client.dart';

final tokenProvider = FutureProvider<String>((ref) async {
  final authRepo = ref.watch(authRepoProvider);

  final token = await authRepo.getTokenFromStorage();

  return token;
});

final uidProvider = FutureProvider<String>((ref) async {
  final token = await ref.watch(tokenProvider.future);

  final uid = JwtExtension.getUserId(token);

  return uid;
});

final socketProvider = Provider.autoDispose((ref) {
  Socket socket = io("http://192.168.0.102:3000/", <String, dynamic>{
    "transports": ["websocket"],
    "autoConnect": false,
    'forceNew': true
  });

  return socket.connect();
});
