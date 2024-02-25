import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lipread/models/history_learning_static_model.dart';
import 'package:lipread/models/history_month_model.dart';
import 'package:lipread/models/message_check_model.dart';
import 'package:lipread/models/message_model.dart';
import 'package:lipread/services/api.dart';
import 'package:lipread/services/token_service.dart';
import 'package:lipread/utilities/variables.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryService {
  static const String user = 'user';
  static const String learningData = 'learningData';

  static Future<HistoryLearningStaticModel> getHistoryLearningStatic() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString('accessToken')!;

    Map<String, String> headers = {
      HttpHeaders.authorizationHeader: "Bearer $accessToken",
    };

    final url = Uri.https(API.baseURL, '$user/$learningData');
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 401) {
      await TokenService.refreshAccessToken();
      getHistoryLearningStatic();
    } else if (response.statusCode == 200) {
      final Map<String, dynamic> body =
          jsonDecode(utf8.decode(response.bodyBytes));
      if (body["data"] != null) {
        return HistoryLearningStaticModel.fromJson(body["data"]);
      }
    }
    throw Error();
  }
}
