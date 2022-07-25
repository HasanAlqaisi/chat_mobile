import 'dart:developer';

import 'package:chat_mobile/utils/errors/exceptions.dart';
import 'package:chat_mobile/utils/errors/failures.dart';
import 'package:chat_mobile/utils/errors/handle_response_exception.dart';
import 'package:dio/dio.dart';

Failure mapExceptionToFailure(Object exception) {
  log(exception.toString());

  if (exception is DioError) {
    switch (exception.error.runtimeType) {
      case ApiTimeoutException:
        return ApiTimeoutFailure();
      case ApiCancelException:
        return ApiCancelFailure();
      case ApiResponseException:
        return handleResponseException(exception.error);
      case ApiUnkownException:
        return ApiUnkownFailure();
      default:
        return ApiUnkownFailure();
    }
  } else {
    switch (exception.runtimeType) {
      case UserNotAuthedException:
        return UserNotAuthedFailure();
      case IncorrectKeyException:
        return IncorrectKeyFailure();
      case ApiUnkownException:
        return ApiUnkownFailure();
      default:
        return ApiUnkownFailure();
    }
  }
}
