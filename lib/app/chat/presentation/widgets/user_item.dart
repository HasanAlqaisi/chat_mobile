import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_mobile/app/chat/presentation/providers/chats_controller.dart';
import 'package:chat_mobile/core/shared/domain/user.dart';
import 'package:chat_mobile/utils/constants/assets_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class UserItem extends ConsumerStatefulWidget {
  final User? user;
  final String? currentUserId;

  const UserItem({
    Key? key,
    required this.user,
    required this.currentUserId,
  }) : super(key: key);

  @override
  UserItemState createState() => UserItemState();
}

class UserItemState extends ConsumerState<UserItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 327.w,
      height: 68.h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.r), // Image border
              child: SizedBox.fromSize(
                size: Size.fromRadius(38.r), // Image radius
                child: widget.user?.profileImage != null
                    ? CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: widget.user!.profileImage!,
                      )
                    : Image.asset(AssetsPath.profilePlaceHolder),
              ),
            ),
          ),
          Text(
            widget.user?.username ?? 'username',
            style: GoogleFonts.mulish(
                fontSize: 16.sp, fontWeight: FontWeight.w500),
          ),
          const Spacer(),
          TextButton(
            onPressed: () {
              ref
                  .read(chatsControllerProvider.notifier)
                  .createChat(widget.currentUserId!, widget.user!.id);
            },
            child: const Text('Request'),
          ),
        ],
      ),
    );
  }
}
