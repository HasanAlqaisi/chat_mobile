import 'package:chat_mobile/app/chat/domain/latest_message.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat.freezed.dart';
part 'chat.g.dart';

@freezed
class Chat with _$Chat {
  factory Chat({
    required String chatId,
    required String userId,
    required bool receiverApprove,
    required String username,
    required String? userImage,
    required int countNewMessages,
    @JsonKey(name: 'message')
    required LatestMessage? latestMessage,
  }) = _Chat;

  factory Chat.fromJson(Map<String, dynamic> json) => _$ChatFromJson(json);
}
