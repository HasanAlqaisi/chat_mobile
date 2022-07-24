import 'package:chat_mobile/data/models/conversation_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ChatBubble extends StatelessWidget {
  final ConversationMessage? message;
  final bool isUser;

  const ChatBubble({
    Key? key,
    required this.message,
    required this.isUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isUser ? Alignment.topRight : Alignment.topLeft,
      child: Container(
        margin: EdgeInsets.all(16.r),
        constraints: BoxConstraints(minWidth: 130.w, minHeight: 60.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomRight:
                isUser ? const Radius.circular(0) : Radius.circular(16.r),
            bottomLeft:
                isUser ? Radius.circular(16.r) : const Radius.circular(0),
            topLeft: Radius.circular(16.r),
            topRight: Radius.circular(16.r),
          ),
          color: isUser ? const Color(0xFF002DE3) : const Color(0xFFd8d8d8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.all(10.0.r),
              child: Text(message?.content ?? 'o',
                  style: GoogleFonts.mulish(
                      color: isUser ? Colors.white : Colors.black)),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10.0.r, right: 10.0.r),
              child: Text(
                DateFormat.jm()
                    .format(DateTime.parse(message!.createdDate).toLocal()),
                style: GoogleFonts.mulish(
                    color: isUser ? Colors.white70 : Colors.black54,
                    fontSize: 10.sp),
                textAlign: TextAlign.end,
              ),
            )
          ],
        ),
      ),
    );
  }
}
