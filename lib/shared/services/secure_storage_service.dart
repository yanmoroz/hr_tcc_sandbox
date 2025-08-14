import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SecureStorageService {
  Future<void> saveString(String key, String value);
  Future<String?> getString(String key);
  Future<void> saveObject(String key, Map<String, dynamic> object);
  Future<Map<String, dynamic>?> getObject(String key);
  Future<void> remove(String key);
  Future<void> clear();
}

class SecureStorageServiceImpl implements SecureStorageService {
  static const String _prefix = 'secure_';

  @override
  Future<void> saveString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('$_prefix$key', value);
  }

  @override
  Future<String?> getString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('$_prefix$key');
  }

  @override
  Future<void> saveObject(String key, Map<String, dynamic> object) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(object);
    await prefs.setString('$_prefix$key', jsonString);
  }

  @override
  Future<Map<String, dynamic>?> getObject(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('$_prefix$key');
    if (jsonString != null) {
      return jsonDecode(jsonString) as Map<String, dynamic>;
    }
    return null;
  }

  @override
  Future<void> remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('$_prefix$key');
  }

  @override
  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys().where((key) => key.startsWith(_prefix));
    for (final key in keys) {
      await prefs.remove(key);
    }
  }
}
