import 'dart:developer';

import 'package:chat_mobile/app/chat/presentation/providers/providers.dart';
import 'package:chat_mobile/app/chat/presentation/providers/user_controller.dart';
import 'package:chat_mobile/app/chat/presentation/widgets/grey_textfield.dart';
import 'package:chat_mobile/app/chat/presentation/widgets/user_item.dart';
import 'package:chat_mobile/core/database/database.dart';
import 'package:chat_mobile/utils/extensions/failure_extension.dart';
import 'package:chat_mobile/utils/errors/map_exception_to_failure.dart';
import 'package:chat_mobile/core/providers.dart';
import 'package:drift_db_viewer/drift_db_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class UsersPage extends ConsumerStatefulWidget {
  const UsersPage({Key? key}) : super(key: key);

  @override
  UsersPageState createState() => UsersPageState();
}

class UsersPageState extends ConsumerState<UsersPage> {
  String? currentUserId;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(uidProvider).whenOrNull(
          error: (e, _) => mapExceptionToFailure(e).showSnackBar(context),
          data: (value) => currentUserId = value,
        );

    final usersAsync = ref.watch(usersStreamProvider(currentUserId));
    final users = usersAsync.asData?.value;

    final db = ref.watch(appDatabaseProvider);

    log(users.toString(), name: 'testing users');

    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => DriftDbViewer(db))),
        child: const Icon(Icons.data_array),
      ),
      appBar: AppBar(
        leading: Icon(Icons.arrow_back_ios, color: Colors.black, size: 18.r),
        title: Text('Find new friend',
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
                ),
                onChanged: (query) => ref
                    .watch(usersControllerProvider.notifier)
                    .searchUsers(query, currentUserId),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: users?.length ?? 0,
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.all(12.0.r),
                    child: UserItem(
                      user: users![index],
                      currentUserId: currentUserId,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
