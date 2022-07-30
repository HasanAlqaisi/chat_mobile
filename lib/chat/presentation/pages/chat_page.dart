import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:chat_mobile/chat/domain/conversation_response.dart';
import 'package:chat_mobile/chat/presentation/providers/providers.dart';
import 'package:chat_mobile/chat/presentation/providers/chat_controller.dart';
import 'package:chat_mobile/chat/presentation/widgets/chat_bubble.dart';
import 'package:chat_mobile/chat/presentation/widgets/grey_textfield.dart';
import 'package:chat_mobile/utils/errors/failure_extension.dart';
import 'package:chat_mobile/utils/errors/map_exception_to_failure.dart';
import 'package:chat_mobile/utils/services/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatPage extends ConsumerStatefulWidget {
  final String chatId;

  const ChatPage({Key? key, @PathParam('id') required this.chatId})
      : super(key: key);

  @override
  ChatPageState createState() => ChatPageState();
}

class ChatPageState extends ConsumerState<ChatPage> {
  String? currentUserId;

  @override
  void initState() {
    super.initState();
    ref.read(authControllerProvider.notifier).getUserId();
    ref.read(chatControllerProvider.notifier).fetchChat(widget.chatId);
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<String?>>(authControllerProvider, (_, state) {
      state.whenOrNull(
        error: (e, _) => mapExceptionToFailure(e).showSnackBar(context),
        data: (value) => currentUserId = value,
      );
    });

    ref.listen<AsyncValue<ConversationResponse?>>(chatControllerProvider,
        (_, state) {
      state.whenOrNull(
          error: (e, _) => mapExceptionToFailure(e).showSnackBar(context));
    });

    final chatState = ref.watch(chatControllerProvider);
    final chat = chatState.asData?.value;

    final contentController = ref.watch(contentControllerProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7FC),
      appBar: AppBar(
        leading: Icon(Icons.arrow_back_ios, color: Colors.black, size: 18.r),
        title: Text(chat?.username ?? 'username',
            style: GoogleFonts.mulish(
              color: Colors.black,
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
            )),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemBuilder: ((context, index) {
                final reversedMessages = chat?.messages.reversed.toList();

                return ChatBubble(
                  message: reversedMessages?[index],
                  isUser: reversedMessages?[index].userId == currentUserId,
                );
              }),
              itemCount: chat?.messages.length ?? 0,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 10.h),
            child: Row(
              children: [
                const Icon(Icons.add, color: Color(0xFFADB5BD)),
                Expanded(
                  child: GreyTextField(
                    hint: 'type a message...',
                    textController: contentController,
                  ),
                ),
                GestureDetector(
                    onTap: (() {
                      ref.read(chatControllerProvider.notifier).fetchMessages(
                            chat!.chatId,
                            null,
                            contentController.text,
                          );
                      contentController.clear();
                    }),
                    child: const Icon(
                      Icons.send,
                      color: Color(0xFF002DE3),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
