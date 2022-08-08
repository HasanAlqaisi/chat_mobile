import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:chat_mobile/app/chat/domain/conversation.dart';
import 'package:chat_mobile/app/chat/presentation/providers/conversation_controller.dart';
import 'package:chat_mobile/app/chat/presentation/providers/chats_controller.dart';
import 'package:chat_mobile/app/chat/presentation/providers/providers.dart';
import 'package:chat_mobile/app/chat/presentation/widgets/conversation_body.dart';
import 'package:chat_mobile/core/services/chat_socket.dart';
import 'package:chat_mobile/utils/errors/map_exception_to_failure.dart';
import 'package:chat_mobile/utils/extensions/failure_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ConversationPage extends ConsumerStatefulWidget {
  final String chatId;
  final String currentUserId;

  const ConversationPage({
    Key? key,
    @PathParam('id') required this.chatId,
    @PathParam('userId') required this.currentUserId,
  }) : super(key: key);

  @override
  ConversationPageState createState() => ConversationPageState();
}

class ConversationPageState extends ConsumerState<ConversationPage> {
  late ChatSocket chatSocket;

  @override
  void initState() {
    super.initState();

    ref
        .read(conversationControllerProvider.notifier)
        .fetchConversation(widget.chatId);

    chatSocket = ref.read(chatSocketProvider);

    chatSocket.onConnect();

    chatSocket.emitOnChat(widget.currentUserId);

    chatSocket.onMessage(
      currentUserId: widget.currentUserId,
      chatId: widget.chatId,
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<Conversation?>>(conversationControllerProvider,
        (_, state) {
      state.whenOrNull(
          error: (e, _) => mapExceptionToFailure(e).showSnackBar(context),
          data: (_) => ref
              .read(chatsControllerProvider.notifier)
              .fetchChats(widget.currentUserId, ''));
    });

    final conversationAsync =
        ref.watch(conversationStreamProvider(widget.chatId));
    final conversation = conversationAsync.asData?.value;

    log(conversation.toString(), name: 'conversation');

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7FC),
      appBar: AppBar(
        leading: Icon(Icons.arrow_back_ios, color: Colors.black, size: 18.r),
        title: Text(conversation?.username ?? 'username',
            style: GoogleFonts.mulish(
              color: Colors.black,
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
            )),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: ConversationBody(
        chat: conversation,
        socket: chatSocket,
      ),
    );
  }
}
