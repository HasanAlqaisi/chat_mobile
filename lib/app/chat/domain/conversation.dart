import 'package:chat_mobile/app/chat/domain/conversation_message.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'conversation.freezed.dart';
part 'conversation.g.dart';

@freezed
class Conversation with _$Conversation {
  factory Conversation({
    required String chatId,
    required String username,
    required String userId,
    required bool isRequesterSender,
    required bool receiverApprove,
    required List<ConversationMessage> messages,
  }) = _Conversation;

  factory Conversation.fromJson(Map<String, dynamic> json) =>
      _$ConversationFromJson(json);
}
