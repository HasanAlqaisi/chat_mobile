import 'package:auto_route/auto_route.dart';
import 'package:chat_mobile/routers/app_paths.dart';
import 'package:chat_mobile/ui/auth/login/widgets/login_body.dart';
import 'package:chat_mobile/utils/app_colors.dart';
import 'package:chat_mobile/utils/common_widgets/auth_curve.dart';
import 'package:chat_mobile/utils/common_widgets/auth_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends ConsumerState<LoginPage> {
  late TapGestureRecognizer _onSignupTap;

  @override
  void initState() {
    super.initState();
    _onSignupTap = TapGestureRecognizer()
      ..onTap = () {
        AutoRouter.of(context).pushNamed(AppPaths.signup);
      };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(25.w, 65.h, 55.w, 36.h),
              child: const AuthImage(),
            ),
            Padding(
              padding: EdgeInsets.only(left: 28.w, right: 32.h, bottom: 40.h),
              child: const LoginBody(),
            ),
            Align(
              alignment: Alignment.center,
              child: Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(text: 'Don\'t have an account? '),
                    TextSpan(
                      text: "signup",
                      style:
                          GoogleFonts.outfit(color: Color(AppColors.darkBlue)),
                      recognizer: _onSignupTap,
                    ),
                  ],
                ),
                style: GoogleFonts.outfit(
                  color: Color(AppColors.gray),
                  fontSize: 16.sp,
                ),
              ),
            ),
            const Align(
              alignment: Alignment.bottomCenter,
              child: AuthCurve(),
            ),
          ],
        ),
      ),
    );
  }
}
