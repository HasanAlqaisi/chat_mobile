import 'package:chat_mobile/app/auth/data/auth_repo.dart';
import 'package:chat_mobile/utils/extensions/jwt_extension.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final tokenProvider = FutureProvider<String>((ref) async {
  final authRepo = ref.watch(authRepoProvider);

  final token = await authRepo.getTokenFromStorage();

  return token;
});

final uidProvider = FutureProvider<String>((ref) async {
  final token = await ref.watch(tokenProvider.future);

  final uid = JwtExtension.getUserId(token);

  return uid;
});
