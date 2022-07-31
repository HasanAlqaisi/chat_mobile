import 'package:auto_route/auto_route.dart';
import 'package:chat_mobile/app/chat/domain/chats_response.dart';
import 'package:chat_mobile/app/chat/presentation/providers/chats_controller.dart';
import 'package:chat_mobile/app/chat/presentation/widgets/chat_item.dart';
import 'package:chat_mobile/app/chat/presentation/widgets/grey_textfield.dart';
import 'package:chat_mobile/routers/app_paths.dart';
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
  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<String>>(uidProvider, (_, state) {
      state.whenOrNull(
        error: (e, _) => mapExceptionToFailure(e).showSnackBar(context),
        data: (uid) =>
            ref.watch(chatsControllerProvider.notifier).fetchChats(uid),
      );
    });

    ref.listen<AsyncValue<List<ChatsResponse>>>(chatsControllerProvider,
        (_, state) {
      state.whenOrNull(
        error: (e, _) => mapExceptionToFailure(e).showSnackBar(context),
      );
    });

    final chatsState = ref.watch(chatsControllerProvider);

    final chats = chatsState.asData?.value;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          Padding(
            padding: EdgeInsets.all(16.0.r),
            child: GestureDetector(
              onTap: () => AutoRouter.of(context).pushNamed(AppPaths.users),
              child: const Icon(Icons.add, color: Colors.black),
            ),
          )
        ],
        title: Text('Chats',
            style: GoogleFonts.mulish(
              color: Colors.black,
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
            )),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0.h, vertical: 14.h),
          child: Column(
            children: [
              GreyTextField(
                  hint: 'serach',
                  icon: Icon(
                    Icons.search,
                    color: const Color(0xFFADB5BD),
                    size: 16.r,
                  )),
              Expanded(
                child: ListView.builder(
                  itemCount: chats?.length ?? 0,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0.h),
                      child: GestureDetector(
                        onTap: () => AutoRouter.of(context)
                            .pushNamed('/${chats![index].chatId}'),
                        child: ChatItem(data: chats![index]),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
