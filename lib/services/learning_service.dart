import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lipread/models/learning_static_model.dart';
import 'package:lipread/models/message/message_check_model.dart';
import 'package:lipread/models/message/message_checks_model.dart';
import 'package:lipread/models/message/message_model.dart';
import 'package:lipread/services/api.dart';
import 'package:lipread/services/token_service.dart';
import 'package:lipread/utilities/variables.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LearningService {
  static const String roleplay = 'roleplay';
  static const String chatList = 'chatList';
  static const String checkChat = 'checkChat';
  static const String learningRecord = 'learningRecord';

  static Future<List<MessageModel>> getMessagesBy(String id) async {
    List<MessageModel> messagesInstances = [];

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString('accessToken')!;

    Map<String, String> headers = {
      HttpHeaders.authorizationHeader: "Bearer $accessToken",
    };

    final url = Uri.https(API.baseURL, '$roleplay/$chatList/$id');
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 401) {
      await TokenService.refreshAccessToken();
      getMessagesBy(id);
    } else if (response.statusCode == 200) {
      final Map<String, dynamic> body =
          jsonDecode(utf8.decode(response.bodyBytes));
      if (body["data"] != null) {
        for (var message in body["data"]['chatList']) {
          messagesInstances.add(MessageModel.fromJson(message));
        }
      }
      return messagesInstances;
    }
    throw Error();
  }

  static Future<MessageChecksModel> checkMessageWith(
      String input, String answer) async {
    bool isSentenceCorrect = true;
    List<MessageCheckModel> messageCheckInstances = [];

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString('accessToken')!;

    Map<String, String> headers = {
      HttpHeaders.authorizationHeader: "Bearer $accessToken",
    };

    var body = json.encode({
      "input": input,
      "answer": answer,
    });

    final url = Uri.https(API.baseURL, '$roleplay/$checkChat');
    final response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    if (response.statusCode == 401) {
      await TokenService.refreshAccessToken();
      checkMessageWith(input, answer);
    } else if (response.statusCode == 200) {
      final Map<String, dynamic> body =
          jsonDecode(utf8.decode(response.bodyBytes));

      if (body["data"] != null) {
        for (var messageCheck in body["data"]['check']) {
          final [code, text] = messageCheck;
          final MessageCodeType codeType = getMessageCodeWith(code);
          if (codeType != MessageCodeType.correct) isSentenceCorrect = false;
          messageCheckInstances.add(MessageCheckModel(
            code: codeType,
            text: text,
          ));
        }
      }
      return MessageChecksModel(
        isCorrect: isSentenceCorrect,
        messageCheck: messageCheckInstances,
      );
    }
    throw Error();
  }

  static Future<LearningStaticModel> getLearningStaticWith(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString('accessToken')!;

    Map<String, String> headers = {
      HttpHeaders.authorizationHeader: "Bearer $accessToken",
    };

    final url = Uri.https(API.baseURL, '$learningRecord/$id');
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 401) {
      await TokenService.refreshAccessToken();
      getMessagesBy(id);
    } else if (response.statusCode == 200) {
      final Map<String, dynamic> body =
          jsonDecode(utf8.decode(response.bodyBytes));
      if (body["data"] != null) {
        return LearningStaticModel.fromJson(body["data"]);
      }
    }
    throw Error();
  }

  static Future<String> saveLearningStatic(
      String id, LearningStaticModel learningResult) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString('accessToken')!;

    Map<String, String> headers = {
      HttpHeaders.authorizationHeader: "Bearer $accessToken",
    };

    var body = json.encode(learningResult.toJson());

    final url = Uri.https(API.baseURL, '$learningRecord/$id');
    final response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    if (response.statusCode == 401) {
      await TokenService.refreshAccessToken();
      saveLearningStatic(id, learningResult);
    } else if (response.statusCode == 200) {
      final Map<String, dynamic> body =
          jsonDecode(utf8.decode(response.bodyBytes));

      if (body["data"] != null) {
        return body["data"]["recordID"];
      }
    }
    throw Error();
  }
}
