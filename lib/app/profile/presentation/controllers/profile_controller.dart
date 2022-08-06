import 'dart:io';

import 'package:chat_mobile/app/auth/domain/user.dart';
import 'package:chat_mobile/app/profile/data/users_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileController extends StateNotifier<AsyncValue<User?>> {
  late ProfileRepo profileRepo;

  ProfileController(this.profileRepo) : super(const AsyncValue.data(null));

  Future<void> fetchProfile() async {
    final getProfile = profileRepo.getProfile;

    state = await AsyncValue.guard(() => getProfile());
  }

  Future<void> editProfile(
    File imageProfile,
    String username,
    String firstname,
    String lastname,
  ) async {
    state = const AsyncValue.loading();

    final editProfile = profileRepo.editProfile;

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
}

final profileControllerProvider =
    StateNotifierProvider.autoDispose<ProfileController, AsyncValue<User?>>(
  (ref) {
    final profileRepo = ref.watch(profileRepoProvider);

    return ProfileController(profileRepo);
  },
);
