import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lipread/models/user_model.dart';
import 'package:lipread/services/api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LoginService {
  static Future<void> saveUser(UserModel user) async {
    final url = Uri.https(API.baseURL, API.login);
    final headers = {HttpHeaders.contentTypeHeader: "application/json"};
    final body = json.encode(user.toJson());

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );

      if (response.statusCode == 201) {
        await _handleSuccessOfSaveUser(response);
      } else {
        _handleErrorOfSaveUser();
      }
    } catch (e) {
      _handleErrorOfSaveUser();
    }
  }

  static Future<void> _handleSuccessOfSaveUser(http.Response response) async {
    final String responseBody = utf8.decode(response.bodyBytes);
    final Map<String, dynamic> json = jsonDecode(responseBody);
    debugPrint('user가 성공적으로 로그인했습니다.');
    final tokens = await _getTokens(json);
    await _saveTokens(tokens);
    await _saveUserId(json['data']['UserId']);
  }

  static Future<List<String>> _getTokens(Map<String, dynamic> json) async {
    final String accessToken = json['data']['accessToken'];
    final String refreshToken = json['data']['refreshToken'];

    debugPrint('accessToken: $accessToken');
    debugPrint('refreshToken: $refreshToken');

    return [accessToken, refreshToken];
  }

  static Future<void> _saveTokens(List<String> tokens) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('accessToken', tokens[0]);
    prefs.setString('refreshToken', tokens[1]);
  }

  static Future<void> _saveUserId(String uid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('uid', uid);
  }

  static void _handleErrorOfSaveUser() {
    debugPrint('user가 로그인하는 것을 실패했습니다.');
  }
}
