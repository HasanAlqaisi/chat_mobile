import 'package:chat_mobile/app/chat/domain/conversation.dart';
import 'package:chat_mobile/app/chat/presentation/providers/conversation_controller.dart';
import 'package:chat_mobile/app/chat/presentation/providers/providers.dart';
import 'package:chat_mobile/app/chat/presentation/widgets/chat_bubble.dart';
import 'package:chat_mobile/app/chat/presentation/widgets/grey_textfield.dart';
import 'package:chat_mobile/core/providers.dart';
import 'package:chat_mobile/core/services/socket.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConversationBody extends ConsumerWidget {
  final Conversation? chat;
  final ChatSocket socket;

  const ConversationBody({
    Key? key,
    required this.chat,
    required this.socket,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUserId = ref.watch(uidProvider).asData!.value;
    final contentController = ref.watch(contentControllerProvider);

    final currentIsSenderAndreceiverNoApprove =
        chat != null && chat!.isRequesterSender && !chat!.receiverApprove;

    final currentIsReceiverAndNotApproved =
        chat != null && !chat!.isRequesterSender && !chat!.receiverApprove;

    if (currentIsSenderAndreceiverNoApprove) {
      return Center(
        child: Text('Waiting ${chat!.username} to approve your request'),
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
                title: Text("${chat!.username} wants to talk. Approve?"),
                subtitle: TextButton(
                  onPressed: () => ref
                      .read(conversationControllerProvider.notifier)
                      .approveChat(chat!.chatId),
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
                      socket.emitOnMessage(
                        currentUserId: currentUserId,
                        chatId: chat!.chatId,
                        content: contentController.text,
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
