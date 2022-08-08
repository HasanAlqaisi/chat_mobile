import 'package:freezed_annotation/freezed_annotation.dart';

part 'seen.freezed.dart';
part 'seen.g.dart';

@freezed
class Seen with _$Seen {
  factory Seen({
    required String userId,
    required String username,
    required String? image,
    required String seenDate,
  }) = _Seen;

  factory Seen.fromJson(Map<String, dynamic> json) => _$SeenFromJson(json);
}
