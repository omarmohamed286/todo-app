import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CacheService {
  final storage = const FlutterSecureStorage();

  Future<void> saveData({required String key, required String value}) async {
    await storage.write(key: key, value: value);
  }

  Future getData({required String key}) async {
    return await storage.read(key: key);
  }
}
