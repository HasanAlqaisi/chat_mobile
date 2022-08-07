import 'dart:convert';

import 'package:chat_mobile/app/shared/domain/user.dart';

class LoginInfo {
  final String accessToken;
  final User user;

  LoginInfo(
    this.accessToken,
    this.user,
  );

  LoginInfo copyWith({
    String? accessToken,
    User? user,
  }) {
    return LoginInfo(
      accessToken ?? this.accessToken,
      user ?? this.user,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'accessToken': accessToken,
      'user': user.toMap(),
    };
  }

  factory LoginInfo.fromMap(Map<String, dynamic> map) {
    return LoginInfo(
      map['accessToken'] as String,
      User.fromMap(map['user'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginInfo.fromJson(String source) =>
      LoginInfo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'LoginInfo(accessToken: $accessToken, user: $user)';

  @override
  bool operator ==(covariant LoginInfo other) {
    if (identical(this, other)) return true;

    return other.accessToken == accessToken && other.user == user;
  }

  @override
  int get hashCode => accessToken.hashCode ^ user.hashCode;
}
