import 'package:chat_mobile/app/shared/domain/user.dart';
import 'package:chat_mobile/app/chat/domain/chat.dart';
import 'package:chat_mobile/app/chat/domain/conversation.dart';
import 'package:chat_mobile/core/database/converters.dart';
import 'package:drift/drift.dart';

@UseRowClass(User)
class Users extends Table {
  TextColumn get id => text()();
  TextColumn get username => text().unique()();
  TextColumn get phoneNumber => text().unique()();
  TextColumn get firstName => text().nullable()();
  TextColumn get lastName => text().nullable()();
  TextColumn get profileImage => text().nullable()();
  DateTimeColumn get lastVisibleDate => dateTime()();

  @override
  Set<Column>? get primaryKey => {id};
}

@UseRowClass(Chat)
class Chats extends Table {
  TextColumn get chatId => text()();
  TextColumn get userId =>
      text().references(Users, #id, onDelete: KeyAction.cascade)();
  BoolColumn get receiverApprove => boolean()();
  TextColumn get username => text().unique()();
  TextColumn get userImage => text().nullable()();
  IntColumn get countNewMessages => integer()();
  TextColumn get latestMessage =>
      text().map(LatestMessageConverter()).nullable()();

  @override
  Set<Column>? get primaryKey => {chatId};
}

@UseRowClass(Conversation)
class Conversations extends Table {
  TextColumn get chatId => text()();
  TextColumn get userId => text()();
  TextColumn get username => text().unique()();
  BoolColumn get receiverApprove => boolean()();
  BoolColumn get isRequesterSender => boolean()();
  TextColumn get messages => text().map(ConversationMessageConverter())();

  @override
  Set<Column>? get primaryKey => {chatId};
}
