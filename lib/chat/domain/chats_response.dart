import 'dart:convert';

import 'package:chat_mobile/chat/domain/latest_message.dart';

class ChatsResponse {
  String chatId;
  bool receiverApprove;
  String username;
  String? userImage;
  int countNewMessages;
  LatestMessage message;

  ChatsResponse({
    required this.chatId,
    required this.receiverApprove,
    required this.username,
    this.userImage,
    required this.countNewMessages,
    required this.message,
  });

  ChatsResponse copyWith({
    String? chatId,
    bool? receiverApprove,
    String? username,
    String? userImage,
    int? countNewMessages,
    LatestMessage? message,
  }) {
    return ChatsResponse(
      chatId: chatId ?? this.chatId,
      receiverApprove: receiverApprove ?? this.receiverApprove,
      username: username ?? this.username,
      userImage: userImage ?? this.userImage,
      countNewMessages: countNewMessages ?? this.countNewMessages,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'chatId': chatId,
      'receiverApprove': receiverApprove,
      'username': username,
      'userImage': userImage,
      'countNewMessages': countNewMessages,
      'message': message.toMap(),
    };
  }

  factory ChatsResponse.fromMap(Map<String, dynamic> map) {
    return ChatsResponse(
      chatId: map['chatId'] as String,
      receiverApprove: map['receiverApprove'] as bool,
      username: map['username'] as String,
      userImage: map['userImage'] != null ? map['userImage'] as String : null,
      countNewMessages: map['countNewMessages'] as int,
      message: LatestMessage.fromMap(map['message'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatsResponse.fromJson(String source) =>
      ChatsResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ChatResponse(chatId: $chatId, receiverApprove: $receiverApprove, username: $username, userImage: $userImage, countNewMessages: $countNewMessages, message: $message)';
  }

  @override
  bool operator ==(covariant ChatsResponse other) {
    if (identical(this, other)) return true;

    return other.chatId == chatId &&
        other.receiverApprove == receiverApprove &&
        other.username == username &&
        other.userImage == userImage &&
        other.countNewMessages == countNewMessages &&
        other.message == message;
  }

  @override
  int get hashCode {
    return chatId.hashCode ^
        receiverApprove.hashCode ^
        username.hashCode ^
        userImage.hashCode ^
        countNewMessages.hashCode ^
        message.hashCode;
  }
}
