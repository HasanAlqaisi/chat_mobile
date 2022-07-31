import 'package:chat_mobile/utils/errors/failures.dart';
import 'package:chat_mobile/utils/errors/map_exception_to_failure.dart';
import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

extension AsyncValueUI on AsyncValue {
  String? showErrorField(String field) => whenOrNull<String?>(error: (e, _) {
        final failure = mapExceptionToFailure(e);
        if (failure is ApiFieldsFailure) {
          return failure.fieldErrors
              .firstWhereOrNull(
                (fieldError) => fieldError?.fieldName == field,
              )
              ?.errors
              .first;
        } else {
          return null;
        }
      });
}
