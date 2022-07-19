import 'package:auto_route/auto_route.dart';
import 'package:chat_mobile/routers/app_router.gr.dart';
import 'package:chat_mobile/ui/auth/otp/providers/otp_notifier.dart';
import 'package:chat_mobile/ui/auth/otp/widgets/otp_image.dart';
import 'package:chat_mobile/ui/auth/signup/providers/state_providers.dart';
import 'package:chat_mobile/utils/app_colors.dart';
import 'package:chat_mobile/utils/errors/data_or_failure.dart';
import 'package:chat_mobile/utils/errors/failures.dart';
import 'package:chat_mobile/utils/errors/get_message_failure.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpPage extends ConsumerStatefulWidget {
  const OtpPage({Key? key}) : super(key: key);

  @override
  OtpPageState createState() => OtpPageState();
}

class OtpPageState extends ConsumerState<OtpPage> {
  late TapGestureRecognizer _onResendTap;

  @override
  void initState() {
    super.initState();
    _onResendTap = TapGestureRecognizer()
      ..onTap = () {
        ref.read(resendOtpNotifierProvider.notifier).resendOtp();
      };
  }

  @override
  Widget build(BuildContext context) {
    final verifyOtpNotifier = ref.watch(verifyOtpNotifierProvider.notifier);
    final phoneNumber = ref.watch(phoneSignupProvider.notifier).state;

    ref.listen<DataOrFailure<String, Failure>?>(
      verifyOtpNotifierProvider,
      ((previous, next) {
        if (next != null) {
          if (next.failure == null && next.data != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(next.data!)),
            );
            AutoRouter.of(context)
                .pushAndPopUntil(const LoginRoute(), predicate: (_) => false);
          } else if (next.failure != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(next.failure!.getMessage())),
            );
          }
        }
      }),
    );

    ref.listen<DataOrFailure<String, Failure>?>(
      resendOtpNotifierProvider,
      ((previous, next) {
        if (next != null) {
          if (next.failure == null && next.data != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(next.data!)),
            );
          } else if (next.failure != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(next.failure!.getMessage())),
            );
          }
        }
      }),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(60.0.w, 90.0.h, 60.0.w, 0.0),
          child: ListView(
            children: [
              const OtpImage(),
              SizedBox(height: 51.h),
              Text(
                'OTP VERIFICATION',
                style: GoogleFonts.outfit(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 13.h),
              Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(text: 'Enter the OTP sent to -'),
                    TextSpan(
                        text: phoneNumber,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                style: GoogleFonts.outfit(fontSize: 14.sp),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 41.h),
              PinCodeTextField(
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
                onChanged: (code) {},
                onCompleted: (code) async =>
                    await verifyOtpNotifier.verifyOtp(code),
                beforeTextPaste: (_) => true,
              ),
              SizedBox(height: 27.h),
              Text(
                '00:00 Sec',
                style: GoogleFonts.outfit(fontSize: 14.sp),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 25.h),
              Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(text: 'Didn\'t receive code? '),
                    TextSpan(
                      text: 'Re-send',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      recognizer: _onResendTap,
                    ),
                  ],
                ),
                style: GoogleFonts.outfit(fontSize: 14.sp),
                textAlign: TextAlign.center,
              ),
              // SizedBox(height: 48.h),
              // AuthButton(
              //   text: "Submit",
              //   fontSize: 18.sp,
              //   fontWeight: FontWeight.w500,
              //   padding: EdgeInsets.all(16.r),
              //   borderRadius: 12.r,
              //   primary: Color(AppColors.otpButtonColor),
              //   surfaceTintColor: Colors.white,
              //   onPressed: () {},
              // ),
              // SizedBox(height: 48.h),
            ],
          ),
        ),
      ),
    );
  }
}
