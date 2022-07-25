import 'package:auto_route/auto_route.dart';
import 'package:chat_mobile/chat/presentation/providers/providers.dart';
import 'package:chat_mobile/chat/presentation/providers/state_notifiers.dart';
import 'package:chat_mobile/chat/presentation/widgets/chat_bubble.dart';
import 'package:chat_mobile/chat/presentation/widgets/grey_textfield.dart';
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
    ref.read(chatStateNotifierProvider.notifier).fetchChat(widget.chatId);
  }

  @override
  Widget build(BuildContext context) {
    final chat = ref.watch(chatStateNotifierProvider);
    final contentController = ref.watch(contentControllerProvider);

    // ref
    //     .watch(getCurrentUserIdProvider.future)
    //     .then(((value) => currentUserId = value));

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
              itemBuilder: ((context, index) => ChatBubble(
                    message: chat?.messages.reversed.toList()[index],
                    isUser: chat?.messages.reversed.toList()[index].userId ==
                        currentUserId,
                  )),
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
                      ref.read(chatStateNotifierProvider.notifier).addMessage(
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
