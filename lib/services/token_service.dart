import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lipread/services/api.dart';
import 'package:lipread/storage/secure_storage.dart';

import 'package:http/http.dart' as http;

class TokenService {
  static Future<String> refreshToken() async {
    final accessToken =
        await SecureStorage.storage.read(key: StorageKey.accessToken);
    final deviceToken =
        await SecureStorage.storage.read(key: StorageKey.deviceToken);
    final refreshToken =
        await SecureStorage.storage.read(key: StorageKey.refreshToken);

    Map<String, String> headers = {
      'Authorization': "Bearer $accessToken",
      'refresh': refreshToken!,
      'devicetoken': deviceToken!,
    };

    try {
      final url = Uri.https(
          "kjs7fnngz2.execute-api.ap-northeast-2.amazonaws.com", Paths.refresh);
      final response = await http.get(
        url,
        headers: headers,
      );

      if (response.statusCode == 201) {
        debugPrint('user가 성공적으로 로그인했습니다.');
        final String responseBody = utf8.decode(response.bodyBytes);
        final Map<String, dynamic> json = jsonDecode(responseBody);
        final String accessToken = json['data']['accessToken'];

        await SecureStorage.storage.write(
          key: StorageKey.accessToken,
          value: accessToken,
        );

        debugPrint('accessToken: $accessToken');
        return accessToken;
      }
    } on DioException catch (e) {
      debugPrint("exception: ${e.message}");
    }
    debugPrint('Token을 Refresh하지 못했습니다.');
    throw Error();
  }
}
