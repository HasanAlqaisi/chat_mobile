import 'package:freezed_annotation/freezed_annotation.dart';

part 'replay.freezed.dart';
part 'replay.g.dart';

@freezed
class Replay with _$Replay {
  factory Replay({
    required String messageId,
    required String content,
  }) = _Replay;

  factory Replay.fromJson(Map<String, dynamic> json) => _$ReplayFromJson(json);
}
