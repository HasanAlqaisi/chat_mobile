import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class SecureStorage {
  Future<void> writeToken(String key, String? value);

  Future<String?> readToken(String key);
}

class _AppSecureStorage implements SecureStorage {
  final FlutterSecureStorage _storage;

  _AppSecureStorage(this._storage);

  @override
  Future<String?> readToken(String key) async {
    return await _storage.read(key: key);
  }

  @override
  Future<void> writeToken(String key, String? value) async {
    return await _storage.write(key: key, value: value);
  }
}

final _flutterSecureStorageProvider = Provider((ref) {
  const androidOptions = AndroidOptions(encryptedSharedPreferences: true);

  return const FlutterSecureStorage(aOptions: androidOptions);
});

final appSecureStorageProvider = Provider((ref) {
  final flutterStorage = ref.watch(_flutterSecureStorageProvider);

  return _AppSecureStorage(flutterStorage);
});
