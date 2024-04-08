import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lipread/models/user_model.dart';
import 'package:lipread/services/api.dart';
import 'package:lipread/storage/secure_storage.dart';
import 'dart:convert';

class LoginService {
  static Future<void> saveUser(UserModel user) async {
    final body = json.encode(user.toJson());

    try {
      final response = await API.dio.post(
        "/${Paths.login}",
        data: body,
        options: Options(
          contentType: "application/json",
        ),
      );

      if (response.statusCode == 201) {
        final String responseBody = utf8.decode(response.data);
        final Map<String, dynamic> json = jsonDecode(responseBody);
        debugPrint('user가 성공적으로 로그인했습니다.');
        final [accessToken, refreshToken] = await _getTokens(json);
        await _saveTokens(accessToken, refreshToken);
        await _saveUserId(json['data']['UID']);
        await _setLoggin();
      }
    } catch (e) {
      debugPrint('user가 로그인하는 것을 실패했습니다.');
    }
  }

  static Future<void> _setLoggin() async {
    await SecureStorage.storage.write(
      key: StorageKey.isLoggedIn,
      value: StorageValue.login,
    );
  }

  static Future<List<String>> _getTokens(Map<String, dynamic> json) async {
    final String accessToken = json['data']['accessToken'];
    final String refreshToken = json['data']['refreshToken'];

    debugPrint('[test] accessToken: $accessToken');
    debugPrint('[test] refreshToken: $refreshToken');

    return [accessToken, refreshToken];
  }

  static Future<void> _saveTokens(
      String accessToken, String refreshToken) async {
    await SecureStorage.storage
        .write(key: StorageKey.accessToken, value: accessToken);
    await SecureStorage.storage
        .write(key: StorageKey.refreshToken, value: refreshToken);
  }

  static Future<void> _saveUserId(String userId) async {
    debugPrint(userId);
    await SecureStorage.storage.write(key: StorageKey.userId, value: userId);
  }
}
