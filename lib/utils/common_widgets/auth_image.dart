import 'package:chat_mobile/utils/constants/assets_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthImage extends StatelessWidget {
  final bool isRed;

  const AuthImage({
    Key? key,
    this.isRed = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 310.w,
      height: 187.h,
      child: SvgPicture.asset(
        isRed ? AssetsPath.signupImage : AssetsPath.loginImage,
      ),
    );
  }
}
