import 'package:auto_route/auto_route.dart';
import 'package:chat_mobile/app/auth/domain/login_info.dart';
import 'package:chat_mobile/app/auth/presentation/login/controllers/login_controller.dart';
import 'package:chat_mobile/app/auth/presentation/login/controllers/providers.dart';
import 'package:chat_mobile/core/common_widgets/auth_button.dart';
import 'package:chat_mobile/core/common_widgets/borderd_text_field.dart';
import 'package:chat_mobile/routers/app_paths.dart';
import 'package:chat_mobile/routers/app_router.gr.dart';
import 'package:chat_mobile/utils/constants/app_colors.dart';
import 'package:chat_mobile/utils/extensions/failure_extension.dart';
import 'package:chat_mobile/utils/errors/map_exception_to_failure.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class LoginBody extends ConsumerWidget {
  const LoginBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = ref.watch(loginFormKeyProvider);

    ref.listen<AsyncValue<LoginInfo?>>(
      loginControllerProvider,
      ((_, state) {
        state.whenOrNull(
          error: (exception, _) =>
              mapExceptionToFailure(exception).showSnackBar(context),
          data: (loginInfo) => loginInfo != null
              ? AutoRouter.of(context)
                  .pushAndPopUntil(const ChatsRoute(), predicate: (_) => false)
              : null,
        );
      }),
    );

    final phoneProvider = ref.watch(loginPhoneTextProvider.notifier);
    final passwordProvider = ref.watch(loginPasswordTextProvider.notifier);

    final shouldButtonEnabled = ref.watch(loginButtonEnabledProvider);
    final shouldShowIndicator =
        ref.watch(loginControllerProvider) is AsyncLoading;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Login Details",
                style: GoogleFonts.outfit(
                    fontSize: 24.sp, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 18.h),
              IntlPhoneField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(20.r),
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0.r),
                  ),
                ),
                flagsButtonMargin: EdgeInsets.all(8.r),
                showCountryFlag: false,
                initialCountryCode: 'IQ',
                validator: (value) {
                  if (value == null || value.number.isEmpty) {
                    return 'Please enter the phone number';
                  }
                  phoneProvider.state = value.completeNumber;
                  return null;
                },
                disableLengthCheck: true,
              ),
              SizedBox(height: 11.h),
              BorderdTextField(
                labelText: "Password",
                contentPadding: EdgeInsets.all(20.0.r),
                borderRadius: 5,
                onChanged: (value) => passwordProvider.state = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the password';
                  }
                  passwordProvider.state = value;
                  return null;
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 6.0.h, bottom: 34.h),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: GestureDetector(
                    child: Text(
                      'Forgot Password ?',
                      style: GoogleFonts.outfit(
                          color: Color(AppColors.gray), fontSize: 16.sp),
                    ),
                    onTap: () =>
                        AutoRouter.of(context).pushNamed(AppPaths.forgotPass),
                  ),
                ),
              ),
              AuthButton(
                text: 'Login',
                showIndicator: shouldShowIndicator,
                padding: EdgeInsets.symmetric(vertical: 12.h),
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                onSurface: Color(AppColors.darkBlue).withOpacity(0.3),
                primary: Color(AppColors.darkBlue),
                surfaceTintColor: Colors.white,
                borderRadius: 5.r,
                onPressed: shouldButtonEnabled
                    ? () async {
                        if (formKey.currentState!.validate()) {
                          await ref
                              .read(loginControllerProvider.notifier)
                              .login(
                                  phoneProvider.state, passwordProvider.state);
                        }
                      }
                    : null,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
