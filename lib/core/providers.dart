import 'package:chat_mobile/core/services/secure_storage.dart';
import 'package:chat_mobile/utils/constants/secrets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:chat_mobile/utils/extensions/jwt_extension.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socket_io_client/socket_io_client.dart';

final tokenProvider = FutureProvider<String?>((ref) async {
  final token =
      await ref.watch(appSecureStorageProvider).readToken(Secrets.tokenKey);

  return token;
});

final uidProvider = FutureProvider<String>((ref) async {
  final token = await ref.watch(tokenProvider.future);

  final uid = JwtExtension.getUserId(token!);

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

final imagePickerProvider = Provider.autoDispose(((ref) => ImagePicker()));
