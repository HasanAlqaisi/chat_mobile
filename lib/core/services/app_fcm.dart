import 'dart:developer';

import 'package:chat_mobile/core/shared/data/messaging_remote.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppFcm {
  final Ref ref;

  AppFcm({required this.ref});

  Future<void> handleMessagingToken(String userId) async {
    log('handle message accessed');
    ref.listen<AsyncValue<String>>(onTokenRefreshProvider, (_, state) async {
      log(state.toString(), name: 'the state of on token');
      final messagingToken = state.asData?.value;
      log('SENDING TOKEN', name: 'handleMessagingToken');
      if (messagingToken != null) {
        await ref
            .read(messagingRemoteProvider)
            .sendMessagingToken(userId, messagingToken);
      }
    });
  }
}

final firebaseMessagingProvider = Provider((_) => FirebaseMessaging.instance);

final onTokenRefreshProvider = StreamProvider((ref) {
  final messaging = ref.watch(firebaseMessagingProvider);

  return messaging.onTokenRefresh;
});

final appFcmProvider = Provider((ref) {
  return AppFcm(ref: ref);
});
