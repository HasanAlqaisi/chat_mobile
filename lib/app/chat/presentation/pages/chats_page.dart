import 'package:auto_route/auto_route.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_mobile/app/chat/domain/chat.dart';
import 'package:chat_mobile/app/chat/presentation/providers/chats_controller.dart';
import 'package:chat_mobile/app/chat/presentation/providers/providers.dart';
import 'package:chat_mobile/app/chat/presentation/widgets/chat_item.dart';
import 'package:chat_mobile/app/chat/presentation/widgets/grey_textfield.dart';
import 'package:chat_mobile/app/profile/presentation/controllers/profile_controller.dart';
import 'package:chat_mobile/app/profile/presentation/controllers/providers.dart';
import 'package:chat_mobile/core/services/app_fcm.dart';
import 'package:chat_mobile/core/shared/domain/user.dart';
import 'package:chat_mobile/core/shared/presentation/data_widget.dart';
import 'package:chat_mobile/core/shared/presentation/place_holder_widget.dart';
import 'package:chat_mobile/routers/app_paths.dart';
import 'package:chat_mobile/utils/constants/assets_path.dart';
import 'package:chat_mobile/utils/extensions/failure_extension.dart';
import 'package:chat_mobile/utils/errors/map_exception_to_failure.dart';
import 'package:chat_mobile/core/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatsPage extends ConsumerStatefulWidget {
  const ChatsPage({Key? key}) : super(key: key);

  @override
  ChatsPageState createState() => ChatsPageState();
}

class ChatsPageState extends ConsumerState<ChatsPage> {
  String? currentUserId;

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<String>>(uidProvider, (_, state) {
      state.whenOrNull(
          error: (e, _) => mapExceptionToFailure(e).showSnackBar(context),
          data: (uid) {
            currentUserId = uid;

            ref.read(appFcmProvider)
              ..getMessagingToken(currentUserId!)
              ..handleMessagingToken(currentUserId!);

            ref
                .watch(chatsControllerProvider.notifier)
                .fetchChats(currentUserId!, '');

            ref.watch(profileControllerProvider.notifier).fetchProfile();
          });
    });

    ref.listen<AsyncValue<List<Chat>>>(chatsControllerProvider, (_, state) {
      state.whenOrNull(
        error: (e, _) => mapExceptionToFailure(e).showSnackBar(context),
      );
    });

    ref.listen<AsyncValue<User?>>(profileControllerProvider, (_, state) {
      state.whenOrNull(
        error: (e, _) => mapExceptionToFailure(e).showSnackBar(context),
      );
    });

    final chatsAsync = ref.watch(chatsStreamProvider(currentUserId));
    final userAsync = ref.watch(userStreamProvider(currentUserId));

    final chats = chatsAsync.asData?.value;
    final user = userAsync.asData?.value;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 8.h, left: 16.w),
              child: Row(
                children: [
                  InkWell(
                    onTap: () =>
                        AutoRouter.of(context).pushNamed(AppPaths.profile),
                    child: Padding(
                      padding: EdgeInsets.only(right: 16.w),
                      child: CircleAvatar(
                        radius: 18.r,
                        backgroundImage: user?.profileImage != null
                            ? CachedNetworkImageProvider(user!.profileImage!)
                            : const AssetImage(AssetsPath.profilePlaceHolder)
                                as ImageProvider<Object>,
                      ),
                    ),
                  ),
                  Text(user?.username ?? 'username',
                      style: GoogleFonts.mulish(
                        color: Colors.black,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                      )),
                  const Spacer(),
                  Padding(
                    padding: EdgeInsets.all(16.0.r),
                    child: GestureDetector(
                      onTap: () =>
                          AutoRouter.of(context).pushNamed(AppPaths.users),
                      // onTap: () => Navigator.of(context).push(
                      // MaterialPageRoute(builder: (context) => DriftDbViewer(db))),
                      child: const Icon(Icons.add, color: Colors.black),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 24.0.h, vertical: 14.h),
                child: Column(
                  children: [
                    GreyTextField(
                        hint: 'serach',
                        onChanged: (value) => ref
                            .read(chatsControllerProvider.notifier)
                            .fetchChats(currentUserId!, value),
                        icon: Icon(
                          Icons.search,
                          color: const Color(0xFFADB5BD),
                          size: 16.r,
                        )),
                    Expanded(
                      child: DataWidget(
                        data: chats,
                        dataWidget: ListView.builder(
                          itemCount: chats?.length ?? 0,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 16.0.h),
                              child: GestureDetector(
                                onTap: () => AutoRouter.of(context).pushNamed(
                                  '/${chats![index].chatId}/$currentUserId',
                                ),
                                child: ChatItem(data: chats![index]),
                              ),
                            );
                          },
                        ),
                        defaultWidget: const PlaceHolderWidget(
                            imagePath: AssetsPath.noChats,
                            text:
                                'No chats ${Emojis.smile_sad_but_relieved_face} Click + to find friends"'),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
