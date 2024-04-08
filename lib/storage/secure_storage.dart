import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static const storage = FlutterSecureStorage();
}

class StorageKey {
  static const String isLoggedIn = 'isLoggedIn';
  static const String userId = 'userId';
  static const String accessToken = 'accessToken';
  static const String refreshToken = 'refreshToken';
  static const String deviceToken = 'deviceToken';
}

class StorageValue {
  static const String login = 'login';
}
