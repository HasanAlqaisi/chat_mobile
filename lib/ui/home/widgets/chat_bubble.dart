import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        margin: EdgeInsets.all(16.r),
        constraints: BoxConstraints(minWidth: 130.w, minHeight: 60.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomRight: const Radius.circular(0),
            bottomLeft: Radius.circular(16.r),
            topLeft: Radius.circular(16.r),
            topRight: Radius.circular(16.r),
          ),
          color: const Color(0xFF002DE3),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.all(10.0.r),
              child: Text('K, I am on my way',
                  style: GoogleFonts.mulish(color: Colors.white)),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10.0.r, right: 10.0.r),
              child: Text(
                '4:30 PM - Read',
                style: GoogleFonts.mulish(color: Colors.white, fontSize: 10.sp),
                textAlign: TextAlign.end,
              ),
            )
          ],
        ),
      ),
    );
  }
}
