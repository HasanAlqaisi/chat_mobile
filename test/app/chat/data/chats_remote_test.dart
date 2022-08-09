// import 'dart:developer';

// import 'package:chat_mobile/app/chat/data/chats_remote.dart';
// import 'package:chat_mobile/app/chat/domain/chat.dart';
// import 'package:chat_mobile/core/network/dio_client.dart';
// import 'package:chat_mobile/core/network/logging_interceptor.dart';
// import 'package:chat_mobile/core/network/token_interceptor.dart';
// import 'package:chat_mobile/core/services/secure_storage.dart';
// import 'package:chat_mobile/routers/app_router.gr.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:http_mock_adapter/http_mock_adapter.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';

// import 'chats_remote_test.mocks.dart';

// @GenerateMocks([
//   Dio,
//   LoggingInterceptors,
//   TokenInterceptors,
//   AppRouter,
//   BaseOptions,
//   // Ref,
//   SecureStorage
// ])
// void main() {
//   // late Dio dio;
//   late DioAdapter dioAdapter;
//   late Dio dio;
//   late ProviderContainer container;
//   late ChatsRemote remote;
//   const route = '/chats';

//   setUp(() {
//     dio = Dio();
//     dioAdapter = DioAdapter(dio: dio);
//     container = ProviderContainer(overrides: [
//       dioProvider.overrideWithValue(dio),
//       loggingInterceptorsProvider.overrideWithValue(MockLoggingInterceptors()),
//       tokenInterceptorsProvider.overrideWithValue(MockTokenInterceptors()),
//     ]);
//     remote = container.read(chatsRemoteProvider);
//   });

//   group('createChat', () {
//     test('return void when success', () async {
//       dioAdapter.onPost(
//           route,
//           data: {"senderId": '', "receiverId": ''},
//           headers: {'requireToken': true},
//           (server) => server.reply(400, null));

//       expect(() async => await remote.createChat('senser', ''), isNotNull);
//     });
//   });

//   group('getChats', () {
//     test('return chats when success', () async {
//       dioAdapter.onGet(
//           '$route/user/userId',
//           queryParameters: {'username': 'query'},
//           headers: {'requireToken': true},
//           (server) => server.reply(200, List<Chat>));

//       final result = await remote.getChats('userId', 'query');

//       expect(result, isA<List<Chat>>());
//     });
//   });
// }
