import 'dart:convert';

import 'package:chat_mobile/chat/domain/conversation_message.dart';
import 'package:flutter/foundation.dart';

class ConversationResponse {
  String chatId;
  String username;
  List<ConversationMessage> messages;

  ConversationResponse({
    required this.chatId,
    required this.username,
    required this.messages,
  });

  ConversationResponse copyWith({
    String? chatId,
    String? username,
    List<ConversationMessage>? messages,
  }) {
    return ConversationResponse(
      chatId: chatId ?? this.chatId,
      username: username ?? this.username,
      messages: messages ?? this.messages,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'chatId': chatId,
      'username': username,
      'messages': messages.map((x) => x.toMap()).toList(),
    };
  }

  factory ConversationResponse.fromMap(Map<String, dynamic> map) {
    return ConversationResponse(
      chatId: map['chatId'] as String,
      username: map['username'] as String,
      messages: List<ConversationMessage>.from(
        (map['messages'] as List).map<ConversationMessage>(
          (x) => ConversationMessage.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ConversationResponse.fromJson(String source) =>
      ConversationResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ChatResponse(chatId: $chatId, username: $username, messages: $messages)';

  @override
  bool operator ==(covariant ConversationResponse other) {
    if (identical(this, other)) return true;

    return other.chatId == chatId &&
        other.username == username &&
        listEquals(other.messages, messages);
  }

  @override
  int get hashCode => chatId.hashCode ^ username.hashCode ^ messages.hashCode;
}
