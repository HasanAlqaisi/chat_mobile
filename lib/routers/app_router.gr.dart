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

import '../ui/auth/forgot_password/pages/forgot_password_page.dart' as _i4;
import '../ui/auth/login/pages/login_page.dart' as _i1;
import '../ui/auth/otp/pages/otp_page.dart' as _i3;
import '../ui/auth/signup/pages/signup_page.dart' as _i2;
import '../ui/home/pages/chat_page.dart' as _i6;
import '../ui/home/pages/chats_page.dart' as _i5;
import '../ui/home/pages/users_page.dart' as _i7;
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
    ChatRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i6.ChatPage());
    },
    UsersRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i7.UsersPage());
    }
  };

  @override
  List<_i8.RouteConfig> get routes => [
        _i8.RouteConfig(LoginRoute.name, path: '/login'),
        _i8.RouteConfig(SignupRoute.name, path: '/signup'),
        _i8.RouteConfig(OtpRoute.name, path: '/otp'),
        _i8.RouteConfig(ForgotPasswordRoute.name, path: '/forgot-pass'),
        _i8.RouteConfig(ChatsRoute.name, path: '/', guards: [authGuard]),
        _i8.RouteConfig(ChatRoute.name, path: '/chat', guards: [authGuard]),
        _i8.RouteConfig(UsersRoute.name, path: '/users', guards: [authGuard])
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
/// [_i6.ChatPage]
class ChatRoute extends _i8.PageRouteInfo<void> {
  const ChatRoute() : super(ChatRoute.name, path: '/chat');

  static const String name = 'ChatRoute';
}

/// generated route for
/// [_i7.UsersPage]
class UsersRoute extends _i8.PageRouteInfo<void> {
  const UsersRoute() : super(UsersRoute.name, path: '/users');

  static const String name = 'UsersRoute';
}
