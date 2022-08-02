import 'package:chat_mobile/app/chat/domain/latest_message.dart';

class Chat {
  String chatId;
  String userId;
  bool receiverApprove;
  String username;
  String? userImage;
  int countNewMessages;
  LatestMessage? latestMessage;

  Chat({
    required this.chatId,
    required this.userId,
    required this.receiverApprove,
    required this.username,
    this.userImage,
    required this.countNewMessages,
    this.latestMessage,
  });

  Chat copyWith({
    String? chatId,
    String? userId,
    bool? receiverApprove,
    String? username,
    String? userImage,
    int? countNewMessages,
    LatestMessage? message,
  }) {
    return Chat(
      chatId: chatId ?? this.chatId,
      userId: userId ?? this.userId,
      receiverApprove: receiverApprove ?? this.receiverApprove,
      username: username ?? this.username,
      userImage: userImage ?? this.userImage,
      countNewMessages: countNewMessages ?? this.countNewMessages,
      latestMessage: message ?? this.latestMessage,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'chatId': chatId,
      'receiverApprove': receiverApprove,
      'username': username,
      'userImage': userImage,
      'countNewMessages': countNewMessages,
      'message': latestMessage?.toMap(),
    };
  }

  factory Chat.fromMap(Map<String, dynamic> map) {
    return Chat(
      chatId: map['chatId'] as String,
      userId: map['userId'] as String,
      receiverApprove: map['receiverApprove'] as bool,
      username: map['username'] as String,
      userImage: map['userImage'] != null ? map['userImage'] as String : null,
      countNewMessages: map['countNewMessages'] as int,
      latestMessage: map['message'] != null
          ? LatestMessage.fromMap(map['message'] as Map<String, dynamic>)
          : null,
    );
  }

  @override
  String toString() {
    return 'ChatsResponse(chatId: $chatId, userId: $userId, receiverApprove: $receiverApprove, username: $username, userImage: $userImage, countNewMessages: $countNewMessages, message: $latestMessage)';
  }

  @override
  bool operator ==(covariant Chat other) {
    if (identical(this, other)) return true;

    return other.chatId == chatId &&
        other.userId == userId &&
        other.receiverApprove == receiverApprove &&
        other.username == username &&
        other.userImage == userImage &&
        other.countNewMessages == countNewMessages &&
        other.latestMessage == latestMessage;
  }

  @override
  int get hashCode {
    return chatId.hashCode ^
        userId.hashCode ^
        receiverApprove.hashCode ^
        username.hashCode ^
        userImage.hashCode ^
        countNewMessages.hashCode ^
        latestMessage.hashCode;
  }
}
