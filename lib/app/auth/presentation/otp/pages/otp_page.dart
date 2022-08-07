import 'package:auto_route/auto_route.dart';
import 'package:chat_mobile/app/auth/presentation/otp/controllers/resend_otp_controller.dart';
import 'package:chat_mobile/app/auth/presentation/otp/controllers/verify_otp_controller.dart';
import 'package:chat_mobile/app/auth/presentation/otp/widgets/otp_image.dart';
import 'package:chat_mobile/app/auth/presentation/otp/widgets/otp_text_field.dart';
import 'package:chat_mobile/app/auth/presentation/signup/controllers/providers.dart';
import 'package:chat_mobile/routers/app_router.gr.dart';
import 'package:chat_mobile/utils/extensions/failure_extension.dart';
import 'package:chat_mobile/utils/errors/map_exception_to_failure.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class OtpPage extends ConsumerWidget {
  const OtpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final phoneNumber = ref.watch(phoneSignupProvider.notifier).state;

    ref.listen<AsyncValue<String?>>(
      verifyOtpControllerProvider,
      ((_, state) => state.whenOrNull(
          error: (exception, _) =>
              mapExceptionToFailure(exception).showSnackBar(context),
          data: (_) => AutoRouter.of(context)
              .pushAndPopUntil(const LoginRoute(), predicate: (_) => false))),
    );

    ref.listen<AsyncValue<String?>>(
      resendOtpControllerProvider,
      ((_, state) => state.whenOrNull(
            error: (exception, _) =>
                mapExceptionToFailure(exception).showSnackBar(context),
            data: (data) => data != null
                ? ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(data)),
                  )
                : null,
          )),
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
              OtpTextField(
                onCompleted: (code) async => await ref
                    .watch(verifyOtpControllerProvider.notifier)
                    .verifyOtp(code),
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
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          ref
                              .read(resendOtpControllerProvider.notifier)
                              .resendOtp();
                        },
                    ),
                  ],
                ),
                style: GoogleFonts.outfit(fontSize: 14.sp),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
