// Mocks generated by Mockito 5.3.0 from annotations
// in chat_mobile/test/app/chat/data/chats_repo_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i12;

import 'package:chat_mobile/app/auth/data/auth_local.dart' as _i8;
import 'package:chat_mobile/app/auth/data/auth_remote.dart' as _i7;
import 'package:chat_mobile/app/auth/data/auth_repo.dart' as _i15;
import 'package:chat_mobile/app/auth/domain/login_info.dart' as _i10;
import 'package:chat_mobile/app/chat/data/chats_local.dart' as _i14;
import 'package:chat_mobile/app/chat/data/chats_remote.dart' as _i11;
import 'package:chat_mobile/app/chat/domain/chat.dart' as _i13;
import 'package:chat_mobile/app/chat/domain/conversation.dart' as _i3;
import 'package:chat_mobile/core/database/dao/chats_dao.dart' as _i4;
import 'package:chat_mobile/core/database/dao/conversations_dao.dart' as _i5;
import 'package:chat_mobile/core/network/dio_client.dart' as _i2;
import 'package:chat_mobile/core/services/secure_storage.dart' as _i9;
import 'package:chat_mobile/core/shared/domain/user.dart' as _i16;
import 'package:flutter_riverpod/flutter_riverpod.dart' as _i6;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeDioClient_0 extends _i1.SmartFake implements _i2.DioClient {
  _FakeDioClient_0(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeConversation_1 extends _i1.SmartFake implements _i3.Conversation {
  _FakeConversation_1(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeChatsDao_2 extends _i1.SmartFake implements _i4.ChatsDao {
  _FakeChatsDao_2(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeConversationsDao_3 extends _i1.SmartFake
    implements _i5.ConversationsDao {
  _FakeConversationsDao_3(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeRef_4 extends _i1.SmartFake implements _i6.Ref {
  _FakeRef_4(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeAuthRemote_5 extends _i1.SmartFake implements _i7.AuthRemote {
  _FakeAuthRemote_5(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeAuthLocal_6 extends _i1.SmartFake implements _i8.AuthLocal {
  _FakeAuthLocal_6(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeSecureStorage_7 extends _i1.SmartFake implements _i9.SecureStorage {
  _FakeSecureStorage_7(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeLoginInfo_8 extends _i1.SmartFake implements _i10.LoginInfo {
  _FakeLoginInfo_8(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

/// A class which mocks [ChatsRemote].
///
/// See the documentation for Mockito's code generation for more information.
class MockChatsRemote extends _i1.Mock implements _i11.ChatsRemote {
  MockChatsRemote() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.DioClient get dioClient => (super.noSuchMethod(
          Invocation.getter(#dioClient),
          returnValue: _FakeDioClient_0(this, Invocation.getter(#dioClient)))
      as _i2.DioClient);
  @override
  _i12.Future<void> createChat(String? senderId, String? receiverId) => (super
          .noSuchMethod(Invocation.method(#createChat, [senderId, receiverId]),
              returnValue: _i12.Future<void>.value(),
              returnValueForMissingStub: _i12.Future<void>.value())
      as _i12.Future<void>);
  @override
  _i12.Future<List<_i13.Chat>> getChats(String? userId, String? query) =>
      (super.noSuchMethod(Invocation.method(#getChats, [userId, query]),
              returnValue: _i12.Future<List<_i13.Chat>>.value(<_i13.Chat>[]))
          as _i12.Future<List<_i13.Chat>>);
  @override
  _i12.Future<_i3.Conversation> getConversation(String? chatId) =>
      (super.noSuchMethod(Invocation.method(#getConversation, [chatId]),
          returnValue: _i12.Future<_i3.Conversation>.value(_FakeConversation_1(
              this, Invocation.method(#getConversation, [chatId])))) as _i12
          .Future<_i3.Conversation>);
  @override
  _i12.Future<void> deleteConversation(String? chatId) =>
      (super.noSuchMethod(Invocation.method(#deleteConversation, [chatId]),
              returnValue: _i12.Future<void>.value(),
              returnValueForMissingStub: _i12.Future<void>.value())
          as _i12.Future<void>);
  @override
  _i12.Future<void> approveConversation(String? chatId) =>
      (super.noSuchMethod(Invocation.method(#approveConversation, [chatId]),
              returnValue: _i12.Future<void>.value(),
              returnValueForMissingStub: _i12.Future<void>.value())
          as _i12.Future<void>);
}

/// A class which mocks [ChatsLocal].
///
/// See the documentation for Mockito's code generation for more information.
class MockChatsLocal extends _i1.Mock implements _i14.ChatsLocal {
  MockChatsLocal() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.ChatsDao get chatsDao => (super.noSuchMethod(Invocation.getter(#chatsDao),
          returnValue: _FakeChatsDao_2(this, Invocation.getter(#chatsDao)))
      as _i4.ChatsDao);
  @override
  _i5.ConversationsDao get conversationsDao => (super.noSuchMethod(
      Invocation.getter(#conversationsDao),
      returnValue: _FakeConversationsDao_3(
          this, Invocation.getter(#conversationsDao))) as _i5.ConversationsDao);
  @override
  _i12.Future<void> upsertChats(List<_i13.Chat>? chats) =>
      (super.noSuchMethod(Invocation.method(#upsertChats, [chats]),
              returnValue: _i12.Future<void>.value(),
              returnValueForMissingStub: _i12.Future<void>.value())
          as _i12.Future<void>);
  @override
  _i12.Stream<List<_i13.Chat>> watchChats(String? currentUserId) =>
      (super.noSuchMethod(Invocation.method(#watchChats, [currentUserId]),
              returnValue: _i12.Stream<List<_i13.Chat>>.empty())
          as _i12.Stream<List<_i13.Chat>>);
  @override
  _i12.Future<void> upsertConversation(_i3.Conversation? conversation) => (super
          .noSuchMethod(Invocation.method(#upsertConversation, [conversation]),
              returnValue: _i12.Future<void>.value(),
              returnValueForMissingStub: _i12.Future<void>.value())
      as _i12.Future<void>);
  @override
  _i12.Stream<_i3.Conversation?> watchConversation(String? chatId) =>
      (super.noSuchMethod(Invocation.method(#watchConversation, [chatId]),
              returnValue: _i12.Stream<_i3.Conversation?>.empty())
          as _i12.Stream<_i3.Conversation?>);
}

/// A class which mocks [AppSecureStorage].
///
/// See the documentation for Mockito's code generation for more information.
class MockAppSecureStorage extends _i1.Mock implements _i9.AppSecureStorage {
  MockAppSecureStorage() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i12.Future<String?> readToken(String? key) =>
      (super.noSuchMethod(Invocation.method(#readToken, [key]),
          returnValue: _i12.Future<String?>.value()) as _i12.Future<String?>);
  @override
  _i12.Future<void> writeToken(String? key, String? value) =>
      (super.noSuchMethod(Invocation.method(#writeToken, [key, value]),
              returnValue: _i12.Future<void>.value(),
              returnValueForMissingStub: _i12.Future<void>.value())
          as _i12.Future<void>);
}

/// A class which mocks [AuthRepo].
///
/// See the documentation for Mockito's code generation for more information.
class MockAuthRepo extends _i1.Mock implements _i15.AuthRepo {
  MockAuthRepo() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Ref get ref => (super.noSuchMethod(Invocation.getter(#ref),
      returnValue: _FakeRef_4(this, Invocation.getter(#ref))) as _i6.Ref);
  @override
  _i7.AuthRemote get authRemote => (super.noSuchMethod(
          Invocation.getter(#authRemote),
          returnValue: _FakeAuthRemote_5(this, Invocation.getter(#authRemote)))
      as _i7.AuthRemote);
  @override
  _i8.AuthLocal get authLocal => (super.noSuchMethod(
          Invocation.getter(#authLocal),
          returnValue: _FakeAuthLocal_6(this, Invocation.getter(#authLocal)))
      as _i8.AuthLocal);
  @override
  _i9.SecureStorage get secureStorage =>
      (super.noSuchMethod(Invocation.getter(#secureStorage),
              returnValue:
                  _FakeSecureStorage_7(this, Invocation.getter(#secureStorage)))
          as _i9.SecureStorage);
  @override
  _i12.Future<String> getTokenFromStorage() =>
      (super.noSuchMethod(Invocation.method(#getTokenFromStorage, []),
          returnValue: _i12.Future<String>.value('')) as _i12.Future<String>);
  @override
  _i12.Future<String> signup(
          String? username, String? phoneNumber, String? password) =>
      (super.noSuchMethod(
          Invocation.method(#signup, [username, phoneNumber, password]),
          returnValue: _i12.Future<String>.value('')) as _i12.Future<String>);
  @override
  _i12.Future<_i10.LoginInfo> login(String? phoneNumber, String? password) =>
      (super.noSuchMethod(Invocation.method(#login, [phoneNumber, password]),
              returnValue: _i12.Future<_i10.LoginInfo>.value(_FakeLoginInfo_8(
                  this, Invocation.method(#login, [phoneNumber, password]))))
          as _i12.Future<_i10.LoginInfo>);
  @override
  _i12.Future<String> verifyOtp(String? phoneNumber, String? password) => (super
      .noSuchMethod(Invocation.method(#verifyOtp, [phoneNumber, password]),
          returnValue: _i12.Future<String>.value('')) as _i12.Future<String>);
  @override
  _i12.Future<String> resendOtp(String? phoneNumber) =>
      (super.noSuchMethod(Invocation.method(#resendOtp, [phoneNumber]),
          returnValue: _i12.Future<String>.value('')) as _i12.Future<String>);
  @override
  _i12.Future<List<_i16.User>> searchUsers(
          String? query, String? currentUserId) =>
      (super.noSuchMethod(
              Invocation.method(#searchUsers, [query, currentUserId]),
              returnValue: _i12.Future<List<_i16.User>>.value(<_i16.User>[]))
          as _i12.Future<List<_i16.User>>);
  @override
  _i12.Stream<List<_i16.User>> watchUsers(String? currentUserId) =>
      (super.noSuchMethod(Invocation.method(#watchUsers, [currentUserId]),
              returnValue: _i12.Stream<List<_i16.User>>.empty())
          as _i12.Stream<List<_i16.User>>);
}
