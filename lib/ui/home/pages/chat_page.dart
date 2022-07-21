import 'package:chat_mobile/ui/home/widgets/chat_bubble.dart';
import 'package:chat_mobile/ui/home/widgets/grey_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7FC),
      appBar: AppBar(
        leading: Icon(Icons.arrow_back_ios, color: Colors.black, size: 18.r),
        title: Text('Hasan Alqaisi',
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
            child: ListView(
              children: List.generate(10, (index) => const ChatBubble()),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 10.h),
            child: Row(
              children: const [
                Icon(Icons.add, color: Color(0xFFADB5BD)),
                Expanded(
                  child: GreyTextField(hint: 'type a message...'),
                ),
                Icon(Icons.send, color: Color(0xFF002DE3)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
