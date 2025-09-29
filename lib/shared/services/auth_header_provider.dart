import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'secure_storage_service.dart';
import '../utils/auth_constants.dart';

abstract class AuthHeaderProvider {
  Future<Map<String, String>> getHeaders();
}

class SecureStorageAuthHeaderProvider implements AuthHeaderProvider {
  final SecureStorageService _storage;

  SecureStorageAuthHeaderProvider(this._storage);

  @override
  Future<Map<String, String>> getHeaders() async {
    try {
      final envToken = dotenv.env['ACCESS_TOKEN'];
      final token = envToken?.isNotEmpty == true
          ? envToken
          : await _storage.getString(AuthConstants.accessTokenKey);
      if (token != null && token.isNotEmpty) {
        return {'Authorization': 'Bearer $token'};
      }
    } catch (e) {
      if (kDebugMode) {
        // swallow and return empty headers in production; just for debugging
        // ignore: avoid_print
        print('AuthHeaderProvider error: $e');
      }
    }
    return const {};
  }
}
