import 'package:chat_mobile/app/chat/domain/conversation_message.dart';
import 'package:flutter/foundation.dart';

class Conversation {
  String chatId;
  String username;
  String userId;
  bool isRequesterSender;
  bool receiverApprove;
  List<ConversationMessage> messages;

  Conversation({
    required this.chatId,
    required this.username,
    required this.userId,
    required this.isRequesterSender,
    required this.receiverApprove,
    required this.messages,
  });

  Conversation copyWith({
    String? chatId,
    String? username,
    String? userId,
    bool? isRequesterSender,
    bool? receiverApprove,
    List<ConversationMessage>? messages,
  }) {
    return Conversation(
      chatId: chatId ?? this.chatId,
      username: username ?? this.username,
      userId: userId ?? this.userId,
      isRequesterSender: isRequesterSender ?? this.isRequesterSender,
      receiverApprove: receiverApprove ?? this.receiverApprove,
      messages: messages ?? this.messages,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'chatId': chatId,
      'username': username,
      'userId': userId,
      'isRequesterSender': isRequesterSender,
      'receiverApprove': receiverApprove,
      'messages': messages.map((x) => x.toMap()).toList(),
    };
  }

  factory Conversation.fromMap(Map<String, dynamic> map) {
    return Conversation(
      chatId: map['chatId'] as String,
      username: map['username'] as String,
      userId: map['userId'] as String,
      isRequesterSender: map['isRequesterSender'] as bool,
      receiverApprove: map['receiverApprove'] as bool,
      messages: List<ConversationMessage>.from(
        (map['messages'] as List).map<ConversationMessage>(
          (x) => ConversationMessage.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  @override
  String toString() {
    return 'ConversationResponse(chatId: $chatId, username: $username, userId: $userId, isRequesterSender: $isRequesterSender, receiverApprove: $receiverApprove, messages: $messages)';
  }

  @override
  bool operator ==(covariant Conversation other) {
    if (identical(this, other)) return true;

    return other.chatId == chatId &&
        other.username == username &&
        other.userId == userId &&
        other.isRequesterSender == isRequesterSender &&
        other.receiverApprove == receiverApprove &&
        listEquals(other.messages, messages);
  }

  @override
  int get hashCode {
    return chatId.hashCode ^
        username.hashCode ^
        userId.hashCode ^
        isRequesterSender.hashCode ^
        receiverApprove.hashCode ^
        messages.hashCode;
  }
}
