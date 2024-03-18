import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lipread/services/api.dart';
import 'package:lipread/utilities/variables.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class TokenProvider with ChangeNotifier {
  late SharedPreferences _preferences;

  String? _deviceToken;
  String? _accessToken;
  String? _refreshToken;

  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
    _deviceToken = await getDeviceToken();
    _accessToken = await getAccessToken();
    _refreshToken = await getRefreshToken();
  }

  Future<String?> getDeviceToken() async {
    if (_deviceToken == null) {
      _preferences = await SharedPreferences.getInstance();
      _deviceToken = _preferences.getString(SharedPreferencesKeys.deviceToken);
    }
    return _deviceToken;
  }

  Future<String?> getAccessToken() async {
    if (_accessToken == null) {
      _preferences = await SharedPreferences.getInstance();
      _accessToken = _preferences.getString(SharedPreferencesKeys.accessToken);
    }
    return _accessToken;
  }

  Future<String?> getRefreshToken() async {
    if (_refreshToken == null) {
      _preferences = await SharedPreferences.getInstance();
      _refreshToken =
          _preferences.getString(SharedPreferencesKeys.refreshToken);
    }
    return _refreshToken;
  }

  Future<void> saveDeviceToken(String token) async {
    await _preferences.setString(SharedPreferencesKeys.deviceToken, token);
    _deviceToken = token;
    notifyListeners();
  }

  Future<void> saveAccessToken(String token) async {
    await _preferences.setString(SharedPreferencesKeys.accessToken, token);
    _accessToken = token;
    notifyListeners();
  }

  Future<void> saveRefreshToken(String token) async {
    await _preferences.setString(SharedPreferencesKeys.refreshToken, token);
    _refreshToken = token;
    notifyListeners();
  }

  Future<void> refreshAccessToken() async {
    String? accessToken = await getAccessToken();
    String? refreshToken = await getRefreshToken();
    String? deviceToken = await getDeviceToken();

    if (accessToken != null && refreshToken != null && deviceToken != null) {
      Map<String, String> headers = {
        'Authorization': 'Bearer $accessToken',
        'refresh': refreshToken,
        'devicetoken': deviceToken,
      };

      final Uri url = Uri.https(API.baseURL, API.refresh);

      try {
        final response = await http.get(
          url,
          headers: headers,
        );

        if (response.statusCode == 201) {
          _handleSuccessOfRefreshingToken(response);
        } else {
          _handleError(response);
        }
      } catch (e) {
        debugPrint(e.toString());
      }
    }
  }

  void _handleSuccessOfRefreshingToken(http.Response response) {
    debugPrint('User가 성공적으로 로그인했습니다.');
    final token = _getAccessToken(response);
    saveAccessToken(token);
  }

  String _getAccessToken(http.Response response) {
    final String responseBody = utf8.decode(response.bodyBytes);
    final Map<String, dynamic> json = jsonDecode(responseBody);

    final String accessToken = json['data']['accessToken'];

    debugPrint('AccessToken: $accessToken');

    return accessToken;
  }

  void _handleError(http.Response response) {
    debugPrint('Token을 Refresh하지 못했습니다.');
  }
}
