import 'package:chat_mobile/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpTextField extends StatelessWidget {
  final Function(String)? onCompleted;
  const OtpTextField({Key? key, required this.onCompleted}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      appContext: context,
      length: 6,
      animationType: AnimationType.fade,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(5),
        fieldHeight: 40.r,
        fieldWidth: 40.r,
        fieldOuterPadding: EdgeInsets.symmetric(horizontal: 4.w),
        activeFillColor: Color(AppColors.otpFieldsColor),
        selectedFillColor: Color(AppColors.otpFieldsColor),
        inactiveFillColor: Color(AppColors.otpFieldsColor),
        borderWidth: 0,
      ),
      animationDuration: const Duration(milliseconds: 300),
      enableActiveFill: true,
      onChanged: (_) {},
      onCompleted: onCompleted,
      beforeTextPaste: (_) => true,
    );
  }
}
