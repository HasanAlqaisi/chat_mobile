import 'package:chat_mobile/auth/presentation/login/widgets/login_curve_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthCurve extends StatelessWidget {
  const AuthCurve({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: LoginCurvePainter(),
      child: SizedBox(
        height: 156.h,
        width: double.infinity,
      ),
    );
  }
}
