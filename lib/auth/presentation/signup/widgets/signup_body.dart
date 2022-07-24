import 'package:auto_route/auto_route.dart';
import 'package:chat_mobile/auth/presentation/signup/providers/signup_notifier.dart';
import 'package:chat_mobile/auth/presentation/signup/providers/state_providers.dart';
import 'package:chat_mobile/routers/app_paths.dart';
import 'package:chat_mobile/utils/app_colors.dart';
import 'package:chat_mobile/utils/common_widgets/auth_button.dart';
import 'package:chat_mobile/utils/common_widgets/auth_text_field.dart';
import 'package:chat_mobile/utils/errors/data_or_failure.dart';
import 'package:chat_mobile/utils/errors/failures.dart';
import 'package:chat_mobile/utils/errors/get_message_failure.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class SignupBody extends ConsumerStatefulWidget {
  const SignupBody({
    Key? key,
  }) : super(key: key);

  @override
  SignupBodyState createState() => SignupBodyState();
}

class SignupBodyState extends ConsumerState<SignupBody> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final buttonEnabledState = ref.watch(signupButtonEnabled);
    final state = ref.watch(signupNotifierProvider);
    final failure = state?.failure;

    final usernameProvider = ref.watch(usernameSignupProvider.notifier);
    final phoneProvider = ref.watch(phoneSignupProvider.notifier);
    final passwordProvider = ref.watch(passwordSignupProvider.notifier);

    ref.listen<DataOrFailure<dynamic, Failure>?>(
      signupNotifierProvider,
      ((previous, current) {
        if (current != null) {
          if (current.failure == null && current.data != null) {
            AutoRouter.of(context).pushNamed(AppPaths.otp);
          } else if (current.failure != null &&
              current.failure is! ApiFieldsFailure) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("error"),
                  content: Text((current.failure!.getMessage())),
                );
              },
            );
          }
        }
      }),
    );

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Signup Details",
                style: GoogleFonts.outfit(
                    fontSize: 24.sp, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 18.h),
              AuthTextField(
                labelText: "Username",
                onChanged: (value) => usernameProvider.state = value,
                errorText: failure is ApiFieldsFailure
                    ? (failure)
                        .fieldErrors
                        .firstWhereOrNull(
                          (fieldError) => fieldError?.fieldName == "username",
                        )
                        ?.errors
                        .first
                    : null,
                contentPadding: EdgeInsets.all(20.0.r),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the username';
                  }
                  usernameProvider.state = value;
                  return null;
                },
              ),
              SizedBox(height: 11.h),
              IntlPhoneField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(20.r),
                  labelText: 'Phone Number',
                  errorText: failure is ApiFieldsFailure
                      ? (failure)
                          .fieldErrors
                          .firstWhereOrNull(
                            (fieldError) =>
                                fieldError?.fieldName == "phoneNumber",
                          )
                          ?.errors
                          .first
                      : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0.r),
                  ),
                ),
                flagsButtonMargin: EdgeInsets.all(8.r),
                showCountryFlag: false,
                initialCountryCode: 'IQ',
                onChanged: (value) =>
                    phoneProvider.state = value.completeNumber,
                validator: (value) {
                  if (value == null || value.number.isEmpty) {
                    return 'Please enter the phone number';
                  }
                  return null;
                },
                disableLengthCheck: true,
              ),
              SizedBox(height: 11.h),
              AuthTextField(
                labelText: "Password",
                onChanged: (value) => passwordProvider.state = value,
                errorText: failure is ApiFieldsFailure
                    ? (failure)
                        .fieldErrors
                        .firstWhereOrNull(
                          (fieldError) => fieldError?.fieldName == "password",
                        )
                        ?.errors
                        .first
                    : null,
                contentPadding: EdgeInsets.all(20.0.r),
                borderRadius: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the password';
                  }
                  passwordProvider.state = value;
                  return null;
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 34.0.h, bottom: 6.h),
                child: AuthButton(
                  text: 'Signup',
                  showIndicator: state == null,
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  onSurface: Color(AppColors.darkBlue).withOpacity(0.3),
                  primary: Color(AppColors.darkBlue),
                  surfaceTintColor: Colors.white,
                  borderRadius: 5.r,
                  onPressed: buttonEnabledState
                      ? () async {
                          if (_formKey.currentState!.validate()) {
                            await ref
                                .read(signupNotifierProvider.notifier)
                                .signup(
                                  usernameProvider.state,
                                  phoneProvider.state,
                                  passwordProvider.state,
                                );
                          }
                        }
                      : null,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
