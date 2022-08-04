import 'package:chat_mobile/app/chat/domain/chat.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_mobile/utils/constants/assets_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatItem extends StatelessWidget {
  final Chat data;

  const ChatItem({
    Key? key,
    required this.data,
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
                  child: data.userImage != null
                      ? CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: data.userImage!,
                        )
                      : Image.asset(AssetsPath.profilePlaceHolder)),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                data.username,
                style: GoogleFonts.mulish(
                    fontSize: 16.sp, fontWeight: FontWeight.w500),
              ),
              Text(
                data.latestMessage?.content ?? 'No messages',
                style: GoogleFonts.mulish(
                    fontSize: 14.sp, color: const Color(0xFFADB5BD)),
              ),
            ],
          ),
          const Spacer(),
          data.latestMessage?.date != null
              ? Text(
                  timeago.format(DateTime.parse(data.latestMessage!.date),
                      locale: 'en_short'),
                  style: GoogleFonts.mulish(
                      fontSize: 12.sp, fontWeight: FontWeight.w600),
                )
              : Container(),
        ],
      ),
    );
  }
}
