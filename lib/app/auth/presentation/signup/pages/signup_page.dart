import 'package:chat_mobile/app/auth/presentation/signup/widgets/signup_body.dart';
import 'package:chat_mobile/core/shared/presentation/auth_curve.dart';
import 'package:chat_mobile/core/shared/presentation/auth_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(25.w, 65.h, 55.w, 36.h),
              child: const AuthImage(isRed: true),
            ),
            Padding(
              padding: EdgeInsets.only(left: 28.w, right: 32.h, bottom: 40.h),
              child: const SignupBody(),
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
