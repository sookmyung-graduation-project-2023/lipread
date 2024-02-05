import 'package:flutter/material.dart';
import 'package:lipread/models/user_model.dart';
import 'package:lipread/services/api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginService {
  static const login = 'login';

  static Future<void> saveUser(UserModel user) async {
    final url = Uri.parse('${API.baseURL}/$login');

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode(user.toJson()),
    );

    if (response.statusCode == 201) {
      debugPrint('user가 성공적으로 로그인했습니다.');
      debugPrint(utf8.decode(response.bodyBytes));
    } else {
      throw Error();
    }
  }
}
