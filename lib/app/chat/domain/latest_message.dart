import 'dart:convert';

class LatestMessage {
  String content;
  bool isNew;
  String date;

  LatestMessage({
    required this.content,
    required this.isNew,
    required this.date,
  });

  LatestMessage copyWith({
    String? content,
    bool? isNew,
    String? date,
  }) {
    return LatestMessage(
      content: content ?? this.content,
      isNew: isNew ?? this.isNew,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'content': content,
      'isNew': isNew,
      'date': date,
    };
  }

  factory LatestMessage.fromMap(Map<String, dynamic> map) {
    return LatestMessage(
      content: map['content'] as String,
      isNew: map['isNew'] as bool,
      date: map['date'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LatestMessage.fromJson(String source) =>
      LatestMessage.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Message(content: $content, isNew: $isNew, date: $date)';

  @override
  bool operator ==(covariant LatestMessage other) {
    if (identical(this, other)) return true;

    return other.content == content &&
        other.isNew == isNew &&
        other.date == date;
  }

  @override
  int get hashCode => content.hashCode ^ isNew.hashCode ^ date.hashCode;
}
