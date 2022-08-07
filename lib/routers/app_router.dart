import 'package:chat_mobile/app/auth/presentation/forgot_password/pages/forgot_password_page.dart';
import 'package:chat_mobile/app/auth/presentation/login/pages/login_page.dart';
import 'package:chat_mobile/app/auth/presentation/otp/pages/otp_page.dart';
import 'package:chat_mobile/app/auth/presentation/signup/pages/signup_page.dart';
import 'package:chat_mobile/app/chat/presentation/pages/conversation_page.dart';
import 'package:chat_mobile/app/chat/presentation/pages/chats_page.dart';
import 'package:chat_mobile/app/chat/presentation/pages/users_page.dart';
import 'package:chat_mobile/app/profile/presentation/pages/profile_page.dart';
import 'package:chat_mobile/routers/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:chat_mobile/routers/app_paths.dart';
import 'package:chat_mobile/routers/auth_guard.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appRouterProvider = Provider<AppRouter>((ref) {
  final authGuard = ref.watch(authGuardProvider);

  return AppRouter(authGuard: authGuard);
});

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: LoginPage, path: AppPaths.login),
    AutoRoute(page: SignupPage, path: AppPaths.signup),
    AutoRoute(page: OtpPage, path: AppPaths.otp),
    AutoRoute(page: ForgotPasswordPage, path: AppPaths.forgotPass),
    AutoRoute(
      page: ChatsPage,
      path: AppPaths.chats,
      guards: [AuthGuard],
    ),
    AutoRoute(
      page: UsersPage,
      path: AppPaths.users,
      guards: [AuthGuard],
    ),
    AutoRoute(
      page: ConversationPage,
      path: AppPaths.chat,
      guards: [AuthGuard],
    ),
    AutoRoute(
      page: ProfilePage,
      path: AppPaths.profile,
      guards: [AuthGuard],
    ),
  ],
)
class $AppRouter {}
