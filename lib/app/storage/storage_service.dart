import 'package:flutter_tetris/app/storage/i_storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService implements IStorageService {
  late final SharedPreferences _sharedPreferences;

  @override
  Future<bool> clear() {
    return _sharedPreferences.clear();
  }

  @override
  String? getString(String key) {
    return _sharedPreferences.getString(key);
  }

  @override
  Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  @override
  Future<bool> setString(String key, String value) {
    return _sharedPreferences.setString(key, value);
  }
}
