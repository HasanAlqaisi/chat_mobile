import 'package:chat_mobile/utils/errors/failures.dart';
import 'package:flutter/material.dart';

extension FailureExtension on Failure {
  String _getMessage() {
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

  void showSnackBar(BuildContext context) {
    if (this is! ApiFieldsFailure) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_getMessage())),
      );
    }
  }

  void showSimpleDialog(BuildContext context) {
    if (this is! ApiFieldsFailure) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Error"),
            content: Text((_getMessage())),
          );
        },
      );
    }
  }
}
