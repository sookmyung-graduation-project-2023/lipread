import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lipread/models/user_model.dart';
import 'package:lipread/services/api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LoginService {
  static const login = 'login';

  static Future<void> saveUser(UserModel user) async {
    final url = Uri.https(API.baseURL, login);
    final headers = {HttpHeaders.contentTypeHeader: "application/json"};
    final body = json.encode(user.toJson());

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );

      if (response.statusCode == 201) {
        _handleSuccessOfSaveUser(response);
      } else {
        _handleErrorOfSaveUser();
      }
    } catch (e) {
      _handleErrorOfSaveUser();
    }
  }

  static void _handleSuccessOfSaveUser(http.Response response) {
    debugPrint('user가 성공적으로 로그인했습니다.');
    final tokens = _getTokens(response);
    _saveTokens(tokens);
  }

  static List<String> _getTokens(http.Response response) {
    final String responseBody = utf8.decode(response.bodyBytes);
    final Map<String, dynamic> json = jsonDecode(responseBody);

    final String accessToken = json['data']['accessToken'];
    final String refreshToken = json['data']['refreshToken'];

    debugPrint('accessToken: $accessToken');
    debugPrint('refreshToken: $refreshToken');

    return [accessToken, refreshToken];
  }

  static void _saveTokens(List<String> tokens) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('accessToken', tokens[0]);
    prefs.setString('refreshToken', tokens[1]);
  }

  static void _handleErrorOfSaveUser() {
    debugPrint('user가 로그인하는 것을 실패했습니다.');
  }
}
