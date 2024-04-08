import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lipread/models/history/history_day_model.dart';
import 'package:lipread/models/history/history_learning_static_model.dart';
import 'package:lipread/models/history/recent_template_model.dart';
import 'package:lipread/services/api.dart';

class HistoryService {
  static Future<HistoryLearningStaticModel?> getLearningStatic() async {
    try {
      Response response =
          await API.dio.get('/${Paths.user}/${Paths.learningData}');
      final Map<String, dynamic> body = jsonDecode(utf8.decode(response.data));
      if (body["data"] != null) {
        return HistoryLearningStaticModel.fromJson(body['data']);
      }
    } on DioException catch (e) {
      debugPrint("exception: ${e.message}");
    }
    throw Error();
  }

  static Future<List<HistorysOfDayModel>> getMonthlyLearningHistory(
      {required int year, required int month}) async {
    List<HistorysOfDayModel> historysOfDaysInstances = [];

    final queryParameters = {
      'year': year.toString(),
      'month': month.toString(),
    };
    try {
      Response response = await API.dio.get(
        '/${Paths.user}/${Paths.monthlyData}',
        queryParameters: queryParameters,
      );
      final Map<String, dynamic> body = jsonDecode(utf8.decode(response.data));
      if (body["data"] != null) {
        for (var history in body["data"]) {
          historysOfDaysInstances.add(HistorysOfDayModel.fromJson(history));
        }
        return historysOfDaysInstances;
      }
    } on DioException catch (e) {
      debugPrint("exception: ${e.message}");
    }
    throw Error();
  }

  static Future<List<RecentTemplateModel>> getRecentLearningTemplates() async {
    List<RecentTemplateModel> recentTemplateInstances = [];

    try {
      Response response = await API.dio.get(
        '/${Paths.user}/${Paths.roleplayList}',
      );
      final Map<String, dynamic> body = jsonDecode(utf8.decode(response.data));
      if (body["data"] != null) {
        for (var history in body["data"]) {
          recentTemplateInstances.add(RecentTemplateModel.fromJson(history));
        }
        return recentTemplateInstances;
      }
    } on DioException catch (e) {
      debugPrint("exception: ${e.message}");
    }
    throw Error();
  }
}
