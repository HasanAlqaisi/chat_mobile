import 'package:chat_mobile/routers/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:chat_mobile/routers/app_paths.dart';
import 'package:chat_mobile/routers/auth_guard.dart';
import 'package:chat_mobile/ui/auth/forgot_password/pages/forgot_password_page.dart';
import 'package:chat_mobile/ui/auth/login/pages/login_page.dart';
import 'package:chat_mobile/ui/auth/otp/pages/otp_page.dart';
import 'package:chat_mobile/ui/auth/signup/pages/signup_page.dart';
import 'package:chat_mobile/ui/home/pages/chats_page.dart';
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
      initial: true,
      path: AppPaths.chats,
      guards: [AuthGuard],
    ),
  ],
)
class $AppRouter {}
