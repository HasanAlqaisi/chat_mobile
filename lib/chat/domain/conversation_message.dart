import 'dart:convert';

import 'package:chat_mobile/chat/domain/replay_to.dart';
import 'package:chat_mobile/chat/domain/seen.dart';
import 'package:flutter/foundation.dart';

class ConversationMessage {
  String id;
  String userId;
  String content;
  String createdDate;
  String updatedDate;
  String? originalMessageId;
  Repaly? repaly;
  List<Seen> sawBy;

  ConversationMessage({
    required this.id,
    required this.userId,
    required this.content,
    required this.createdDate,
    required this.updatedDate,
    this.originalMessageId,
    this.repaly,
    required this.sawBy,
  });

  ConversationMessage copyWith({
    String? id,
    String? userId,
    String? content,
    String? createdDate,
    String? updatedDate,
    String? originalMessageId,
    Repaly? repaly,
    List<Seen>? sawBy,
  }) {
    return ConversationMessage(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      content: content ?? this.content,
      createdDate: createdDate ?? this.createdDate,
      updatedDate: updatedDate ?? this.updatedDate,
      originalMessageId: originalMessageId ?? this.originalMessageId,
      repaly: repaly ?? this.repaly,
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
      'repalyTo': repaly?.toMap(),
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
      repaly: map['repalyTo'] != null
          ? Repaly.fromMap(map['repalyTo'] as Map<String, dynamic>)
          : null,
      sawBy: List<Seen>.from(
        (map['sawBy'] as List).map<Seen>(
          (x) => Seen.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ConversationMessage.fromJson(String source) =>
      ConversationMessage.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ChatMessage(id: $id, userId: $userId, content: $content, createdDate: $createdDate, updatedDate: $updatedDate, originalMessageId: $originalMessageId, repalyTo: $repaly, sawBy: $sawBy)';
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
        other.repaly == repaly &&
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
        repaly.hashCode ^
        sawBy.hashCode;
  }
}
