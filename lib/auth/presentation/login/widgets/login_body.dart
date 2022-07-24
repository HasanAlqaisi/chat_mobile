import 'package:auto_route/auto_route.dart';
import 'package:chat_mobile/auth/presentation/login/providers/login_notifier.dart';
import 'package:chat_mobile/auth/presentation/login/providers/state_providers.dart';
import 'package:chat_mobile/routers/app_paths.dart';
import 'package:chat_mobile/routers/app_router.gr.dart';
import 'package:chat_mobile/utils/app_colors.dart';
import 'package:chat_mobile/utils/common_widgets/auth_button.dart';
import 'package:chat_mobile/utils/common_widgets/auth_text_field.dart';
import 'package:chat_mobile/utils/errors/data_or_failure.dart';
import 'package:chat_mobile/utils/errors/failures.dart';
import 'package:chat_mobile/utils/errors/get_message_failure.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class LoginBody extends ConsumerStatefulWidget {
  const LoginBody({
    Key? key,
  }) : super(key: key);

  @override
  LoginBodyState createState() => LoginBodyState();
}

class LoginBodyState extends ConsumerState<LoginBody> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ref.listen<DataOrFailure<dynamic, Failure>?>(
      loginNotifierProvider,
      ((previous, current) {
        if (current != null) {
          if (current.failure != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(current.failure!.getMessage())),
            );
          } else if (current.data != null) {
            AutoRouter.of(context)
                .pushAndPopUntil(const ChatsRoute(), predicate: (_) => false);
          }
        }
      }),
    );

    final phoneProvider = ref.watch(phoneTextProvider.notifier);
    final passwordProvider = ref.watch(passwordTextProvider.notifier);

    final shouldButtonEnabled = ref.watch(buttonEnabledProvider);
    final shouldShowIndicator = ref.watch(loginNotifierProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Form(
          key: _formKey,
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
                // onChanged: (value) => phoneProvider.state = value.number,
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
              AuthTextField(
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
                showIndicator: shouldShowIndicator == null,
                padding: EdgeInsets.symmetric(vertical: 12.h),
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                onSurface: Color(AppColors.darkBlue).withOpacity(0.3),
                primary: Color(AppColors.darkBlue),
                surfaceTintColor: Colors.white,
                borderRadius: 5.r,
                onPressed: shouldButtonEnabled
                    ? () async {
                        if (_formKey.currentState!.validate()) {
                          await ref.read(loginNotifierProvider.notifier).login(
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
