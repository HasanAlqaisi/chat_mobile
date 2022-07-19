import 'package:chat_mobile/utils/errors/exceptions.dart';
import 'package:chat_mobile/utils/errors/failures.dart';

Failure handleResponseErrors(ApiResponseException error) {
  switch (error.type) {
    case 'SIMPLE':
      return ApiGeneralFailure.fromJson(error.body!);
    case 'ZOD_FLATTENED':
      return ApiFieldsFailure.decodeFieldsErrors(error.body!);
    case 'DB_OPERATION':
      return ApiGeneralFailure.fromJson(error.body!);
    case 'UNHANDLED_ERROR':
      return ApiGeneralFailure.fromJson(error.body!);
    case 'SERVER_ERROR':
      return ApiGeneralFailure.fromJson(error.body!);
    default:
      return ApiGeneralFailure.fromJson(error.body!);
  }
}
