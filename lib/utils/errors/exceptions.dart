class ApiTimeoutException implements Exception {
  final String? message;

  ApiTimeoutException({this.message});
}

class ApiResponseException implements Exception {
  final dynamic body;
  final dynamic type;

  ApiResponseException({this.body, required this.type});
}

class ApiCancelException implements Exception {
  final String? message;

  ApiCancelException({this.message});
}

class ApiUnkownException implements Exception {
  final String? message;

  ApiUnkownException({this.message});
}

class UserNotAuthedException implements Exception {}

class IncorrectKeyException implements Exception {
  final String key;
  final String? message;

  IncorrectKeyException({required this.key, this.message});
}
