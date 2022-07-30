import 'dart:convert';

class Repaly {
  String messageId;
  String content;

  Repaly({
    required this.messageId,
    required this.content,
  });

  Repaly copyWith({
    String? messageId,
    String? content,
  }) {
    return Repaly(
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

  factory Repaly.fromMap(Map<String, dynamic> map) {
    return Repaly(
      messageId: map['messageId'] as String,
      content: map['content'] as String,
    );
  }

  @override
  String toString() => 'RepalyTo(messageId: $messageId, content: $content)';

  @override
  bool operator ==(covariant Repaly other) {
    if (identical(this, other)) return true;

    return other.messageId == messageId && other.content == content;
  }

  @override
  int get hashCode => messageId.hashCode ^ content.hashCode;
}
