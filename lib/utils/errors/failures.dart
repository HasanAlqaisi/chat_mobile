import 'package:chat_mobile/core/models/field_errors_model.dart';

abstract class Failure {}

class ApiTimeoutFailure implements Failure {
  final String message;

  ApiTimeoutFailure({this.message = "Timeout Error"});
}

class ApiCancelFailure implements Failure {
  final String message;

  ApiCancelFailure({this.message = "Request Canceled"});
}

class ApiUnkownFailure implements Failure {
  final String message;

  ApiUnkownFailure({this.message = "Unkown Error"});
}

class ApiFieldsFailure implements Failure {
  final List<FieldErrors?> fieldErrors;

  ApiFieldsFailure._({required this.fieldErrors});

  factory ApiFieldsFailure.decodeFieldsErrors(Map<String, dynamic> body) {
    List<FieldErrors> fieldErrors = [];

    body["fieldErrors"].forEach((key, value) {
      List<String> errors = [];

      value.forEach((error) => errors.add(error));
      fieldErrors.add(FieldErrors(fieldName: key, errors: errors));
    });

    return ApiFieldsFailure._(fieldErrors: fieldErrors);
  }
}

class ApiGeneralFailure implements Failure {
  final String detail;

  ApiGeneralFailure._({required this.detail});

  factory ApiGeneralFailure.fromJson(Map<String, dynamic> json) {
    final detail = json['detail'];

    return ApiGeneralFailure._(detail: detail ?? "not detail error");
  }
}

class UserNotAuthedFailure implements Failure {}

class IncorrectKeyFailure implements Failure {}
