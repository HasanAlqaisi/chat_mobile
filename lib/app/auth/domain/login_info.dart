import 'package:chat_mobile/core/shared/domain/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_info.freezed.dart';
part 'login_info.g.dart';

@freezed
class LoginInfo with _$LoginInfo {
  factory LoginInfo({
    required String accessToken,
    required User user,
  }) = _LoginInfo;

  factory LoginInfo.fromJson(Map<String, dynamic> json) =>
      _$LoginInfoFromJson(json);
}
