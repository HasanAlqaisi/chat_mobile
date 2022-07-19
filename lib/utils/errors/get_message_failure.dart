import 'package:chat_mobile/utils/errors/failures.dart';

extension Parse on Failure {
  String getMessage() {
    switch (runtimeType) {
      case ApiGeneralFailure:
        return (this as ApiGeneralFailure).detail;
      case ApiTimeoutFailure:
        return (this as ApiTimeoutFailure).message;
      case ApiFieldsFailure:
        return (this as ApiFieldsFailure).fieldErrors.toString();
      case ApiCancelFailure:
        return (this as ApiCancelFailure).message;
      case ApiUnkownFailure:
        return (this as ApiUnkownFailure).message;
      default:
        return 'unhandled error';
    }
  }
}
