import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:chat_mobile/app/chat/domain/conversation.dart';
import 'package:chat_mobile/app/chat/presentation/providers/chat_controller.dart';
import 'package:chat_mobile/app/chat/presentation/providers/providers.dart';
import 'package:chat_mobile/app/chat/presentation/widgets/chat_bubble.dart';
import 'package:chat_mobile/app/chat/presentation/widgets/grey_textfield.dart';
import 'package:chat_mobile/core/providers.dart';
import 'package:chat_mobile/utils/errors/map_exception_to_failure.dart';
import 'package:chat_mobile/utils/extensions/failure_extension.dart';
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
    ref.read(chatControllerProvider.notifier).fetchChat(widget.chatId);
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(uidProvider).whenOrNull(
          error: (e, _) => mapExceptionToFailure(e).showSnackBar(context),
          data: (value) => currentUserId = value,
        );

    ref.listen<AsyncValue<Conversation?>>(chatControllerProvider, (_, state) {
      state.whenOrNull(
        error: (e, _) => mapExceptionToFailure(e).showSnackBar(context),
      );
    });

    final chatAsync = ref.watch(conversationStreamProvider(widget.chatId));
    final chat = chatAsync.asData?.value;

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
      body: temp(chat, contentController),
    );
  }

  Widget temp(Conversation? chat, TextEditingController contentController) {
    final currentIsSenderAndreceiverNoApprove =
        chat != null && chat.isRequesterSender && !chat.receiverApprove;

    final currentIsReceiverAndNotApproved =
        chat != null && !chat.isRequesterSender && !chat.receiverApprove;

    if (currentIsSenderAndreceiverNoApprove) {
      return Center(
        child: Text('Waiting ${chat.username} to approve your request'),
      );
    } else if (currentIsReceiverAndNotApproved) {
      return Center(
        child: FractionallySizedBox(
          heightFactor: 0.5,
          widthFactor: 0.75,
          child: Card(
            elevation: 2,
            shadowColor: Colors.blue,
            margin: const EdgeInsets.all(20),
            shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.white)),
            child: Center(
              child: ListTile(
                title: Text("${chat.username} wants to talk. Approve?"),
                subtitle: TextButton(
                  onPressed: () => ref
                      .read(chatControllerProvider.notifier)
                      .approveChat(chat.chatId),
                  child: const Icon(Icons.check, size: 32),
                ),
              ),
            ),
          ),
        ),
      );
    } else {
      return Column(
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
                            currentUserId!,
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
      );
    }
  }
}
