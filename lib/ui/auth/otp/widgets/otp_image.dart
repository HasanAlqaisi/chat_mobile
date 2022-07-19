import 'package:chat_mobile/utils/constants/assets_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OtpImage extends StatelessWidget {
  const OtpImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 258.w,
      height: 307.h,
      child: SvgPicture.asset(
        AssetsPath.otpImage,
      ),
    );
  }
}
