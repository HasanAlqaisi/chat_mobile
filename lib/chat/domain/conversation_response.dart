import 'dart:convert';

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

class ConversationMessage {
  String id;
  String userId;
  String content;
  String createdDate;
  String updatedDate;
  String? originalMessageId;
  RepalyTo? repalyTo;
  List<Seens> sawBy;

  ConversationMessage({
    required this.id,
    required this.userId,
    required this.content,
    required this.createdDate,
    required this.updatedDate,
    this.originalMessageId,
    this.repalyTo,
    required this.sawBy,
  });

  ConversationMessage copyWith({
    String? id,
    String? userId,
    String? content,
    String? createdDate,
    String? updatedDate,
    String? originalMessageId,
    RepalyTo? repalyTo,
    List<Seens>? sawBy,
  }) {
    return ConversationMessage(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      content: content ?? this.content,
      createdDate: createdDate ?? this.createdDate,
      updatedDate: updatedDate ?? this.updatedDate,
      originalMessageId: originalMessageId ?? this.originalMessageId,
      repalyTo: repalyTo ?? this.repalyTo,
      sawBy: sawBy ?? this.sawBy,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userId': userId,
      'content': content,
      'createdDate': createdDate,
      'updatedDate': updatedDate,
      'originalMessageId': originalMessageId,
      'repalyTo': repalyTo?.toMap(),
      'sawBy': sawBy.map((x) => x.toMap()).toList(),
    };
  }

  factory ConversationMessage.fromMap(Map<String, dynamic> map) {
    return ConversationMessage(
      id: map['id'] as String,
      userId: map['userId'] as String,
      content: map['content'] as String,
      createdDate: map['createdDate'] as String,
      updatedDate: map['updatedDate'] as String,
      originalMessageId: map['originalMessageId'] != null
          ? map['originalMessageId'] as String
          : null,
      repalyTo: map['repalyTo'] != null
          ? RepalyTo.fromMap(map['repalyTo'] as Map<String, dynamic>)
          : null,
      sawBy: List<Seens>.from(
        (map['sawBy'] as List).map<Seens>(
          (x) => Seens.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ConversationMessage.fromJson(String source) =>
      ConversationMessage.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ChatMessage(id: $id, userId: $userId, content: $content, createdDate: $createdDate, updatedDate: $updatedDate, originalMessageId: $originalMessageId, repalyTo: $repalyTo, sawBy: $sawBy)';
  }

  @override
  bool operator ==(covariant ConversationMessage other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.userId == userId &&
        other.content == content &&
        other.createdDate == createdDate &&
        other.updatedDate == updatedDate &&
        other.originalMessageId == originalMessageId &&
        other.repalyTo == repalyTo &&
        listEquals(other.sawBy, sawBy);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        userId.hashCode ^
        content.hashCode ^
        createdDate.hashCode ^
        updatedDate.hashCode ^
        originalMessageId.hashCode ^
        repalyTo.hashCode ^
        sawBy.hashCode;
  }
}

class RepalyTo {
  String messageId;
  String content;

  RepalyTo({
    required this.messageId,
    required this.content,
  });

  RepalyTo copyWith({
    String? messageId,
    String? content,
  }) {
    return RepalyTo(
      messageId: messageId ?? this.messageId,
      content: content ?? this.content,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'messageId': messageId,
      'content': content,
    };
  }

  factory RepalyTo.fromMap(Map<String, dynamic> map) {
    return RepalyTo(
      messageId: map['messageId'] as String,
      content: map['content'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory RepalyTo.fromJson(String source) =>
      RepalyTo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'RepalyTo(messageId: $messageId, content: $content)';

  @override
  bool operator ==(covariant RepalyTo other) {
    if (identical(this, other)) return true;

    return other.messageId == messageId && other.content == content;
  }

  @override
  int get hashCode => messageId.hashCode ^ content.hashCode;
}

class Seens {
  String userId;
  String username;
  String? image;
  String seenDate;

  Seens({
    required this.userId,
    required this.username,
    this.image,
    required this.seenDate,
  });

  Seens copyWith({
    String? userId,
    String? username,
    String? image,
    String? seenDate,
  }) {
    return Seens(
      userId: userId ?? this.userId,
      username: username ?? this.username,
      image: image ?? this.image,
      seenDate: seenDate ?? this.seenDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'username': username,
      'image': image,
      'seenDate': seenDate,
    };
  }

  factory Seens.fromMap(Map<String, dynamic> map) {
    return Seens(
      userId: map['userId'] as String,
      username: map['username'] as String,
      image: map['image'] != null ? map['image'] as String : null,
      seenDate: map['seenDate'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Seens.fromJson(String source) =>
      Seens.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Seens(userId: $userId, username: $username, image: $image, seenDate: $seenDate)';
  }

  @override
  bool operator ==(covariant Seens other) {
    if (identical(this, other)) return true;

    return other.userId == userId &&
        other.username == username &&
        other.image == image &&
        other.seenDate == seenDate;
  }

  @override
  int get hashCode {
    return userId.hashCode ^
        username.hashCode ^
        image.hashCode ^
        seenDate.hashCode;
  }
}
