import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lipread/models/history/history_day_model.dart';
import 'package:lipread/models/history/history_learning_static_model.dart';
import 'package:lipread/services/api.dart';
import 'package:lipread/services/token_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryService {
  static const String user = 'user';
  static const String learningData = 'learningData';
  static const String monthlyData = 'monthlyData';

  static Future<HistoryLearningStaticModel> getLearningStatic() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString('accessToken')!;

    Map<String, String> headers = {
      HttpHeaders.authorizationHeader: "Bearer $accessToken",
    };

    final url = Uri.https(API.baseURL, '$user/$learningData');
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 401) {
      await TokenService.refreshAccessToken();
      getLearningStatic();
    } else if (response.statusCode == 200) {
      final Map<String, dynamic> body =
          jsonDecode(utf8.decode(response.bodyBytes));
      if (body["data"] != null) {
        return HistoryLearningStaticModel.fromJson(body['data']);
      }
    }
    throw Error();
  }

  static Future<List<HistorysOfDayModel>> getMonthlyLearningHistory(
      {required int year, required int month}) async {
    List<HistorysOfDayModel> historysOfDaysInstances = [];

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString('accessToken')!;

    Map<String, String> headers = {
      HttpHeaders.authorizationHeader: "Bearer $accessToken",
    };

    final queryParameters = {
      'year': year.toString(),
      'month': month.toString(),
    };

    final url = Uri.https(API.baseURL, '$user/$monthlyData', queryParameters);
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 401) {
      await TokenService.refreshAccessToken();
      getMonthlyLearningHistory(year: year, month: month);
    } else if (response.statusCode == 200) {
      final Map<String, dynamic> body =
          jsonDecode(utf8.decode(response.bodyBytes));
      if (body["data"] != null) {
        for (var history in body["data"]) {
          historysOfDaysInstances.add(HistorysOfDayModel.fromJson(history));
        }
        return historysOfDaysInstances;
      }
    }
    throw Exception('달 정보를 가져오는데 실패했습니다');
  }
}
