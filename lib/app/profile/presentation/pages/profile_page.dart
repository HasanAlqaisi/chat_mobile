import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_mobile/app/shared/domain/user.dart';
import 'package:chat_mobile/app/profile/presentation/controllers/profile_controller.dart';
import 'package:chat_mobile/app/profile/presentation/controllers/providers.dart';
import 'package:chat_mobile/app/shared/presentation/borderd_text_field.dart';
import 'package:chat_mobile/core/providers.dart';
import 'package:chat_mobile/utils/constants/assets_path.dart';
import 'package:chat_mobile/utils/errors/map_exception_to_failure.dart';
import 'package:chat_mobile/utils/extensions/failure_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends ConsumerState<ProfilePage> {
  @override
  void initState() {
    super.initState();
    ref.read(profileControllerProvider.notifier).fetchProfile();
  }

  @override
  Widget build(BuildContext context) {
    final formKey = ref.watch(formKeyProvider);

    final uid = ref.watch(uidProvider).asData!.value;

    final profileAsync = ref.watch(userStreamProvider(uid));

    final profile = profileAsync.asData?.value;

    final usernameProfile = ref.watch(usernameProfileProvider.state).state;
    final firstnameProfile = ref.watch(firstnameProfileProvider.state).state;
    final lastnameProfile = ref.watch(lastNameProfileProvider.state).state;

    ref.listen<AsyncValue<User?>>(profileControllerProvider, (_, state) {
      state.whenOrNull(
          error: (e, _) => mapExceptionToFailure(e).showSnackBar(context),
          data: (profile) {
            usernameProfile.text = profile?.username ?? '';
            firstnameProfile.text = profile?.firstName ?? '';
            lastnameProfile.text = profile?.lastName ?? '';
            ref.read(shouldShowFileImageProvider.state).state = false;
          });
    });

    return Scaffold(
      body: SafeArea(
          child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            children: [
              Container(
                height: 188.h,
                color: const Color(0xFFFF8D76),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              Expanded(
                child: Form(
                    key: formKey,
                    child: Padding(
                      padding: EdgeInsets.all(32.r),
                      child: ListView(
                        children: [
                          BorderdTextField(
                            controller: usernameProfile,
                            labelText: 'username',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter the username';
                              }
                              usernameProfile.text = value;
                              return null;
                            },
                            contentPadding: EdgeInsets.all(18.r),
                            borderRadius: 8.r,
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.02),
                          BorderdTextField(
                            labelText: 'First Name',
                            controller: firstnameProfile,
                            validator: (value) {
                              if (value == null) {
                                return 'Please enter the first name';
                              }
                              firstnameProfile.text = value;
                              return null;
                            },
                            contentPadding: EdgeInsets.all(18.r),
                            borderRadius: 8.r,
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.02),
                          BorderdTextField(
                            labelText: 'Last Name',
                            controller: lastnameProfile,
                            validator: (value) {
                              if (value == null) {
                                return 'Please enter the last name';
                              }
                              lastnameProfile.text = value;
                              return null;
                            },
                            contentPadding: EdgeInsets.all(18.r),
                            borderRadius: 8.r,
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.02),
                        ],
                      ),
                    )),
              ),
            ],
          ),
          Positioned(
            width: MediaQuery.of(context).size.width,
            top: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_back_ios),
                  color: Colors.white,
                ),
                Text('Edit profile',
                    style: GoogleFonts.poppins(
                      fontSize: 15.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    )),
                IconButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        await ref
                            .read(profileControllerProvider.notifier)
                            .editProfile(
                              ref.read(imageFileProvider.state).state!,
                              usernameProfile.text,
                              firstnameProfile.text,
                              lastnameProfile.text,
                            );
                      }
                    },
                    icon: const Icon(
                      Icons.check,
                      color: Colors.white,
                    )),
              ],
            ),
          ),
          Positioned(
            top: 120.h,
            child: InkWell(
              onTap: ref.watch(profileControllerProvider.notifier).onImageTap,
              child: CircleAvatar(
                radius: 64.r,
                backgroundImage: _displayFromImageSource(profile),
              ),
            ),
          ),
        ],
      )),
    );
  }

  ImageProvider<Object> _displayFromImageSource(User? profile) {
    final shouldShowPickedFile =
        ref.watch(shouldShowFileImageProvider.state).state;
    final hasProfileImage = profile?.profileImage != null;

    if (shouldShowPickedFile) {
      return FileImage(ref.watch(imageFileProvider.state).state!);
    } else if (hasProfileImage) {
      return CachedNetworkImageProvider(profile!.profileImage!);
    } else {
      return const AssetImage(AssetsPath.profilePlaceHolder);
    }
  }
}
