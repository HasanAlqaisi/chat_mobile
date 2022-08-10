import 'dart:convert';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:chat_mobile/core/services/notification.dart';
import 'package:chat_mobile/routers/app_router.dart';
import 'package:chat_mobile/routers/app_router.gr.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await AppNotification(awesomeNotifications: AwesomeNotifications())
      .createMessageChatNotification(
    json.decode(message.data.entries.first.value),
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final container = ProviderContainer();

  final notification = container.read(appNotificationProvider);

  await notification.checkNotificationPermission();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(UncontrolledProviderScope(
    container: container,
    child: const App(),
  ));
}

class App extends ConsumerStatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  AppState createState() => AppState();
}

class AppState extends ConsumerState<App> {
  late AppRouter _appRouter;

  @override
  void initState() {
    super.initState();
    _appRouter = ref.read(appRouterProvider);
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          routerDelegate: _appRouter.delegate(),
          routeInformationParser: _appRouter.defaultRouteParser(),
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
        );
      },
      // child: const LoginPage(),
    );
  }
}
