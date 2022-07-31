import 'package:chat_mobile/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';

class LoginCurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    Path path = Path();

    paint.color = Color(AppColors.curveColor).withOpacity(0.3);
    path = Path();
    path.lineTo(0, size.height * 0.8);
    path.cubicTo(0, size.height * 0.8, size.width * 0.02, size.height * 0.74,
        size.width * 0.02, size.height * 0.74);
    path.cubicTo(size.width * 0.05, size.height * 0.67, size.width * 0.09,
        size.height * 0.53, size.width * 0.14, size.height * 0.51);
    path.cubicTo(size.width * 0.19, size.height / 2, size.width * 0.24,
        size.height * 0.6, size.width * 0.28, size.height * 0.62);
    path.cubicTo(size.width / 3, size.height * 0.63, size.width * 0.38,
        size.height * 0.56, size.width * 0.43, size.height * 0.53);
    path.cubicTo(size.width * 0.48, size.height / 2, size.width * 0.52,
        size.height / 2, size.width * 0.57, size.height * 0.55);
    path.cubicTo(size.width * 0.62, size.height * 0.6, size.width * 0.67,
        size.height * 0.7, size.width * 0.72, size.height * 0.7);
    path.cubicTo(size.width * 0.76, size.height * 0.7, size.width * 0.81,
        size.height * 0.6, size.width * 0.86, size.height * 0.47);
    path.cubicTo(size.width * 0.91, size.height / 3, size.width * 0.95,
        size.height * 0.17, size.width * 0.98, size.height * 0.09);
    path.cubicTo(
        size.width * 0.98, size.height * 0.09, size.width, 0, size.width, 0);
    path.cubicTo(
        size.width, 0, size.width, size.height, size.width, size.height);
    path.cubicTo(size.width, size.height, size.width * 0.98, size.height,
        size.width * 0.98, size.height);
    path.cubicTo(size.width * 0.95, size.height, size.width * 0.91, size.height,
        size.width * 0.86, size.height);
    path.cubicTo(size.width * 0.81, size.height, size.width * 0.76, size.height,
        size.width * 0.72, size.height);
    path.cubicTo(size.width * 0.67, size.height, size.width * 0.62, size.height,
        size.width * 0.57, size.height);
    path.cubicTo(size.width * 0.52, size.height, size.width * 0.48, size.height,
        size.width * 0.43, size.height);
    path.cubicTo(size.width * 0.38, size.height, size.width / 3, size.height,
        size.width * 0.28, size.height);
    path.cubicTo(size.width * 0.24, size.height, size.width * 0.19, size.height,
        size.width * 0.14, size.height);
    path.cubicTo(size.width * 0.09, size.height, size.width * 0.05, size.height,
        size.width * 0.02, size.height);
    path.cubicTo(
        size.width * 0.02, size.height, 0, size.height, 0, size.height);
    path.cubicTo(0, size.height, 0, size.height * 0.8, 0, size.height * 0.8);
    path.cubicTo(
        0, size.height * 0.8, 0, size.height * 0.8, 0, size.height * 0.8);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
