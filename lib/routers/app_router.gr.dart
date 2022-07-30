// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i8;
import 'package:flutter/material.dart' as _i9;

import '../auth/presentation/forgot_password/pages/forgot_password_page.dart'
    as _i4;
import '../auth/presentation/login/pages/login_page.dart' as _i1;
import '../auth/presentation/otp/pages/otp_page.dart' as _i3;
import '../auth/presentation/signup/pages/signup_page.dart' as _i2;
import '../chat/presentation/pages/chat_page.dart' as _i7;
import '../chat/presentation/pages/chats_page.dart' as _i5;
import '../chat/presentation/pages/users_page.dart' as _i6;
import 'auth_guard.dart' as _i10;

class AppRouter extends _i8.RootStackRouter {
  AppRouter(
      {_i9.GlobalKey<_i9.NavigatorState>? navigatorKey,
      required this.authGuard})
      : super(navigatorKey);

  final _i10.AuthGuard authGuard;

  @override
  final Map<String, _i8.PageFactory> pagesMap = {
    LoginRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.LoginPage());
    },
    SignupRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.SignupPage());
    },
    OtpRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.OtpPage());
    },
    ForgotPasswordRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i4.ForgotPasswordPage());
    },
    ChatsRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i5.ChatsPage());
    },
    UsersRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i6.UsersPage());
    },
    ChatRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ChatRouteArgs>(
          orElse: () => ChatRouteArgs(chatId: pathParams.getString('id')));
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i7.ChatPage(key: args.key, chatId: args.chatId));
    }
  };

  @override
  List<_i8.RouteConfig> get routes => [
        _i8.RouteConfig(LoginRoute.name, path: '/login'),
        _i8.RouteConfig(SignupRoute.name, path: '/signup'),
        _i8.RouteConfig(OtpRoute.name, path: '/otp'),
        _i8.RouteConfig(ForgotPasswordRoute.name, path: '/forgot-pass'),
        _i8.RouteConfig(ChatsRoute.name, path: '/', guards: [authGuard]),
        _i8.RouteConfig(UsersRoute.name, path: '/users', guards: [authGuard]),
        _i8.RouteConfig(ChatRoute.name, path: '/:id', guards: [authGuard])
      ];
}

/// generated route for
/// [_i1.LoginPage]
class LoginRoute extends _i8.PageRouteInfo<void> {
  const LoginRoute() : super(LoginRoute.name, path: '/login');

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i2.SignupPage]
class SignupRoute extends _i8.PageRouteInfo<void> {
  const SignupRoute() : super(SignupRoute.name, path: '/signup');

  static const String name = 'SignupRoute';
}

/// generated route for
/// [_i3.OtpPage]
class OtpRoute extends _i8.PageRouteInfo<void> {
  const OtpRoute() : super(OtpRoute.name, path: '/otp');

  static const String name = 'OtpRoute';
}

/// generated route for
/// [_i4.ForgotPasswordPage]
class ForgotPasswordRoute extends _i8.PageRouteInfo<void> {
  const ForgotPasswordRoute()
      : super(ForgotPasswordRoute.name, path: '/forgot-pass');

  static const String name = 'ForgotPasswordRoute';
}

/// generated route for
/// [_i5.ChatsPage]
class ChatsRoute extends _i8.PageRouteInfo<void> {
  const ChatsRoute() : super(ChatsRoute.name, path: '/');

  static const String name = 'ChatsRoute';
}

/// generated route for
/// [_i6.UsersPage]
class UsersRoute extends _i8.PageRouteInfo<void> {
  const UsersRoute() : super(UsersRoute.name, path: '/users');

  static const String name = 'UsersRoute';
}

/// generated route for
/// [_i7.ChatPage]
class ChatRoute extends _i8.PageRouteInfo<ChatRouteArgs> {
  ChatRoute({_i9.Key? key, required String chatId})
      : super(ChatRoute.name,
            path: '/:id',
            args: ChatRouteArgs(key: key, chatId: chatId),
            rawPathParams: {'id': chatId});

  static const String name = 'ChatRoute';
}

class ChatRouteArgs {
  const ChatRouteArgs({this.key, required this.chatId});

  final _i9.Key? key;

  final String chatId;

  @override
  String toString() {
    return 'ChatRouteArgs{key: $key, chatId: $chatId}';
  }
}
