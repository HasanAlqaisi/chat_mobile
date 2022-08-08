import 'dart:convert';

import 'package:chat_mobile/app/chat/domain/conversation_message.dart';
import 'package:chat_mobile/app/chat/domain/latest_message.dart';
import 'package:drift/drift.dart';

class LatestMessageConverter extends TypeConverter<LatestMessage?, String>
    with JsonTypeConverter<LatestMessage?, String> {
  @override
  LatestMessage? mapToDart(String? fromDb) {
    if (fromDb == null) {
      return null;
    }

    return LatestMessage.fromJson(json.decode(fromDb) as Map<String, dynamic>);
  }

  @override
  String? mapToSql(LatestMessage? value) {
    if (value == null) {
      return null;
    }

    return json.encode(value.toJson());
  }
}

class ConversationMessageConverter
    extends TypeConverter<List<ConversationMessage>, String>
    with JsonTypeConverter<List<ConversationMessage>, String> {
  @override
  List<ConversationMessage>? mapToDart(String? fromDb) {
    if (fromDb == null) return null;

    final List<ConversationMessage> messages = [];

    final jsonData = json.decode(fromDb);

    for (final string in jsonData) {
      final message = ConversationMessage.fromJson(string);
      messages.add(message);
    }

    return messages;
  }

  @override
  String? mapToSql(List<ConversationMessage>? value) {
    if (value == null) return null;

    return json.encode(value.map((message) => message.toJson()).toList());
  }
}
