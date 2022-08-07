import 'dart:io';

import 'package:chat_mobile/app/auth/domain/user.dart';
import 'package:chat_mobile/app/profile/data/users_repo.dart';
import 'package:chat_mobile/app/profile/presentation/controllers/providers.dart';
import 'package:chat_mobile/core/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends StateNotifier<AsyncValue<User?>> {
  late Ref ref;

  ProfileController(this.ref) : super(const AsyncValue.data(null));

  Future<void> fetchProfile() async {
    final getProfile = ref.read(profileRepoProvider).getProfile;

    state = await AsyncValue.guard(() => getProfile());
  }

  Future<void> editProfile(
    File imageProfile,
    String username,
    String firstname,
    String lastname,
  ) async {
    state = const AsyncValue.loading();

    final editProfile = ref.read(profileRepoProvider).editProfile;

    final res = await AsyncValue.guard(() => editProfile(
          imageProfile,
          username,
          firstname,
          lastname,
        ));

    if (res is AsyncError) {
      state = AsyncError(res);
    }

    await fetchProfile();
  }

  Future<void> onImageTap() async {
    final imagePicker = ref.read(imagePickerProvider);

    final imageFile = ref.read(imageFileProvider.state);

    final xfile = await imagePicker.pickImage(source: ImageSource.gallery);

    imageFile.state = File(xfile!.path);

    ref.read(shouldShowFileImageProvider.state).state = true;
  }
}

final profileControllerProvider =
    StateNotifierProvider.autoDispose<ProfileController, AsyncValue<User?>>(
  (ref) {
    return ProfileController(ref);
  },
);
