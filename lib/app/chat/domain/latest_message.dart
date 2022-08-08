import 'package:freezed_annotation/freezed_annotation.dart';

part 'latest_message.freezed.dart';
part 'latest_message.g.dart';

@freezed
class LatestMessage with _$LatestMessage {
  factory LatestMessage({
    required String content,
    required bool isNew,
    required String date,
  }) = _LatestMessage;

  factory LatestMessage.fromJson(Map<String, dynamic> json) =>
      _$LatestMessageFromJson(json);
}
