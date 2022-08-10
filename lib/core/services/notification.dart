import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AppNotification {
  final AwesomeNotifications awesomeNotifications;

  AppNotification({required this.awesomeNotifications}) {
    _initawesomeNotifications();
  }

  void _initawesomeNotifications() {
    awesomeNotifications.initialize(
      // set the icon to null if you want to use the default app icon
      null,
      [
        NotificationChannel(
          channelKey: 'messages_channel',
          channelName: 'Messages notifications',
          channelDescription:
              'A notification channel that will tell you when someone sends you a message!',
          defaultColor: const Color(0xFF9D50DD),
          ledColor: Colors.green,
        )
      ],
      debug: true,
    );
  }

  Future<void> checkNotificationPermission() async {
    await awesomeNotifications.isNotificationAllowed().then((isAllowed) async {
      if (!isAllowed) {
        await awesomeNotifications.requestPermissionToSendNotifications();
      }
    });
  }

  Future<bool> createMessageChatNotification(Map<String, dynamic> data) async {
    return await awesomeNotifications.createNotificationFromJsonData(data);
  }
}

final awesomeNotificationsProvider = Provider((_) => AwesomeNotifications());

final appNotificationProvider = Provider((ref) {
  final awesomeNotifications = ref.watch(awesomeNotificationsProvider);

  return AppNotification(awesomeNotifications: awesomeNotifications);
});
