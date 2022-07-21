import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatItem extends StatelessWidget {
  const ChatItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 327.w,
      height: 68.h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.r), // Image border
              child: SizedBox.fromSize(
                  size: Size.fromRadius(38.r), // Image radius
                  child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl:
                          'https://i.ibb.co/KKnRXhp/photo-2022-04-07-01-31-50.jpg')),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Hasan Alqaisi',
                style: GoogleFonts.mulish(
                    fontSize: 16.sp, fontWeight: FontWeight.w500),
              ),
              Text(
                'Good morning',
                style: GoogleFonts.mulish(
                    fontSize: 14.sp, color: const Color(0xFFADB5BD)),
              ),
            ],
          ),
          const Spacer(),
          Text(
            '3m ago',
            style: GoogleFonts.mulish(
                fontSize: 12.sp, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
