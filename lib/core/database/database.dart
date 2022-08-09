import 'dart:io';
import 'package:chat_mobile/app/shared/domain/user.dart';
import 'package:chat_mobile/app/chat/domain/chat.dart';
import 'package:chat_mobile/app/chat/domain/conversation.dart';
import 'package:chat_mobile/app/chat/domain/conversation_message.dart';
import 'package:chat_mobile/app/chat/domain/latest_message.dart';
import 'package:chat_mobile/core/database/converters.dart';
import 'package:chat_mobile/core/database/dao/chats_dao.dart';
import 'package:chat_mobile/core/database/dao/conversations_dao.dart';
import 'package:chat_mobile/core/database/dao/users_dao.dart';
import 'package:chat_mobile/core/database/tables.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart';

@DriftDatabase(
  tables: [Users, Chats, Conversations],
  daos: [UsersDao, ChatsDao, ConversationsDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(QueryExecutor e) : super(e);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        beforeOpen: (details) async =>
            await customStatement('PRAGMA foreign_keys = ON'),
      );
}

final appDatabaseProvider = Provider(((ref) {
  final e = LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    final dbFolder = await getApplicationDocumentsDirectory();

    final file = File(p.join(dbFolder.path, 'db.sqlite'));

    return NativeDatabase(file);
  });

  return AppDatabase(e);
}));
