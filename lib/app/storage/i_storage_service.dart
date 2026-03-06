abstract interface class IStorageService {
  Future<void> init();

  Future<bool> setString(String key, String value);

  String? getString(String key);

  Future<bool> clear();
}
