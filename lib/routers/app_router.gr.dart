// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i9;
import 'package:flutter/material.dart' as _i10;

import '../app/auth/presentation/forgot_password/pages/forgot_password_page.dart'
    as _i4;
import '../app/auth/presentation/login/pages/login_page.dart' as _i1;
import '../app/auth/presentation/otp/pages/otp_page.dart' as _i3;
import '../app/auth/presentation/signup/pages/signup_page.dart' as _i2;
import '../app/chat/presentation/pages/chat_page.dart' as _i7;
import '../app/chat/presentation/pages/chats_page.dart' as _i5;
import '../app/chat/presentation/pages/users_page.dart' as _i6;
import '../app/profile/presentation/pages/profile_page.dart' as _i8;
import 'auth_guard.dart' as _i11;

class AppRouter extends _i9.RootStackRouter {
  AppRouter(
      {_i10.GlobalKey<_i10.NavigatorState>? navigatorKey,
      required this.authGuard})
      : super(navigatorKey);

  final _i11.AuthGuard authGuard;

  @override
  final Map<String, _i9.PageFactory> pagesMap = {
    LoginRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.LoginPage());
    },
    SignupRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.SignupPage());
    },
    OtpRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.OtpPage());
    },
    ForgotPasswordRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i4.ForgotPasswordPage());
    },
    ChatsRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i5.ChatsPage());
    },
    UsersRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i6.UsersPage());
    },
    ChatRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ChatRouteArgs>(
          orElse: () => ChatRouteArgs(
              chatId: pathParams.getString('id'),
              currentUserId: pathParams.getString('userId')));
      return _i9.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i7.ChatPage(
              key: args.key,
              chatId: args.chatId,
              currentUserId: args.currentUserId));
    },
    ProfileRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i8.ProfilePage());
    }
  };

  @override
  List<_i9.RouteConfig> get routes => [
        _i9.RouteConfig(LoginRoute.name, path: '/login'),
        _i9.RouteConfig(SignupRoute.name, path: '/signup'),
        _i9.RouteConfig(OtpRoute.name, path: '/otp'),
        _i9.RouteConfig(ForgotPasswordRoute.name, path: '/forgot-pass'),
        _i9.RouteConfig(ChatsRoute.name, path: '/', guards: [authGuard]),
        _i9.RouteConfig(UsersRoute.name, path: '/users', guards: [authGuard]),
        _i9.RouteConfig(ChatRoute.name,
            path: '/:id/:userId', guards: [authGuard]),
        _i9.RouteConfig(ProfileRoute.name,
            path: '/profile/', guards: [authGuard])
      ];
}

/// generated route for
/// [_i1.LoginPage]
class LoginRoute extends _i9.PageRouteInfo<void> {
  const LoginRoute() : super(LoginRoute.name, path: '/login');

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i2.SignupPage]
class SignupRoute extends _i9.PageRouteInfo<void> {
  const SignupRoute() : super(SignupRoute.name, path: '/signup');

  static const String name = 'SignupRoute';
}

/// generated route for
/// [_i3.OtpPage]
class OtpRoute extends _i9.PageRouteInfo<void> {
  const OtpRoute() : super(OtpRoute.name, path: '/otp');

  static const String name = 'OtpRoute';
}

/// generated route for
/// [_i4.ForgotPasswordPage]
class ForgotPasswordRoute extends _i9.PageRouteInfo<void> {
  const ForgotPasswordRoute()
      : super(ForgotPasswordRoute.name, path: '/forgot-pass');

  static const String name = 'ForgotPasswordRoute';
}

/// generated route for
/// [_i5.ChatsPage]
class ChatsRoute extends _i9.PageRouteInfo<void> {
  const ChatsRoute() : super(ChatsRoute.name, path: '/');

  static const String name = 'ChatsRoute';
}

/// generated route for
/// [_i6.UsersPage]
class UsersRoute extends _i9.PageRouteInfo<void> {
  const UsersRoute() : super(UsersRoute.name, path: '/users');

  static const String name = 'UsersRoute';
}

/// generated route for
/// [_i7.ChatPage]
class ChatRoute extends _i9.PageRouteInfo<ChatRouteArgs> {
  ChatRoute(
      {_i10.Key? key, required String chatId, required String currentUserId})
      : super(ChatRoute.name,
            path: '/:id/:userId',
            args: ChatRouteArgs(
                key: key, chatId: chatId, currentUserId: currentUserId),
            rawPathParams: {'id': chatId, 'userId': currentUserId});

  static const String name = 'ChatRoute';
}

class ChatRouteArgs {
  const ChatRouteArgs(
      {this.key, required this.chatId, required this.currentUserId});

  final _i10.Key? key;

  final String chatId;

  final String currentUserId;

  @override
  String toString() {
    return 'ChatRouteArgs{key: $key, chatId: $chatId, currentUserId: $currentUserId}';
  }
}

/// generated route for
/// [_i8.ProfilePage]
class ProfileRoute extends _i9.PageRouteInfo<void> {
  const ProfileRoute() : super(ProfileRoute.name, path: '/profile/');

  static const String name = 'ProfileRoute';
}
