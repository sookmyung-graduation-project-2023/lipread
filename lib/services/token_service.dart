import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lipread/services/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class TokenService {
  static const refresh = 'refresh';

  static Future<void> refreshAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString('accessToken')!;
    String refreshToken = prefs.getString('refreshToken')!;

    Map<String, String> headers = {
      HttpHeaders.authorizationHeader: "Bearer $accessToken",
      'refresh': refreshToken,
    };

    final url = Uri.parse('${API.baseURL}/$refresh');

    try {
      final response = await http.post(
        url,
        headers: headers,
      );

      if (response.statusCode == 201) {
        _handleSuccessOfRefreshingToken(response);
      } else {
        _handleError(response);
      }
    } catch (e) {}
  }

  static void _handleSuccessOfRefreshingToken(http.Response response) {
    debugPrint('user가 성공적으로 로그인했습니다.');
    final token = _getAccessToken(response);
    _saveAccessToken(token);
  }

  static String _getAccessToken(http.Response response) {
    final String responseBody = utf8.decode(response.bodyBytes);
    final Map<String, dynamic> json = jsonDecode(responseBody);

    final String accessToken = json['data']['accessToken'];

    debugPrint('accessToken: $accessToken');

    return accessToken;
  }

  static void _saveAccessToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('accessToken', token);
  }

  static void _handleError(http.Response response) {
    debugPrint('Token을 Refresh하지 못했습니다.');
    final String responseBody = utf8.decode(response.bodyBytes);
    final Map<String, dynamic> json = jsonDecode(responseBody);
  }
}
