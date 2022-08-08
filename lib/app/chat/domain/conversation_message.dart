import 'package:chat_mobile/app/chat/domain/replay.dart';
import 'package:chat_mobile/app/chat/domain/seen.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'conversation_message.freezed.dart';
part 'conversation_message.g.dart';

@freezed
class ConversationMessage with _$ConversationMessage {
  factory ConversationMessage({
    required String id,
    required String userId,
    required String content,
    required String createdDate,
    required String updatedDate,
    required String? originalMessageId,
    required Replay? repaly,
    required List<Seen> sawBy,
  }) = _ConversationMessage;

  factory ConversationMessage.fromJson(Map<String, dynamic> json) =>
      _$ConversationMessageFromJson(json);
}
