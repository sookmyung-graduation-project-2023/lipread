import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lipread/models/learning_static_model.dart';
import 'package:lipread/models/message/message_check_model.dart';
import 'package:lipread/models/message/message_checks_model.dart';
import 'package:lipread/models/message/message_model.dart';
import 'package:lipread/services/api.dart';
import 'package:lipread/utilities/variables.dart';

class LearningService {
  static Future<List<MessageModel>> getMessagesBy(String id) async {
    List<MessageModel> messagesInstances = [];

    try {
      Response response =
          await API.dio.get('/${Paths.roleplay}/${Paths.chatList}/$id');

      final Map<String, dynamic> body = jsonDecode(utf8.decode(response.data));
      if (body["data"] != null) {
        for (var message in body["data"]['chatList']) {
          messagesInstances.add(MessageModel.fromJson(message));
        }
        return messagesInstances;
      }
    } on DioException catch (e) {
      debugPrint(e.message);
    }
    throw Error();
  }

  static Future<MessageChecksModel> checkMessageWith(
      String input, String answer) async {
    bool isSentenceCorrect = true;
    List<MessageCheckModel> messageCheckInstances = [];

    var data = json.encode({
      "input": input,
      "answer": answer,
    });

    try {
      Response response = await API.dio
          .post('/${Paths.roleplay}/${Paths.checkChat}', data: data);

      final Map<String, dynamic> body = jsonDecode(utf8.decode(response.data));
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
        return MessageChecksModel(
          isCorrect: isSentenceCorrect,
          messageCheck: messageCheckInstances,
        );
      }
    } on DioException catch (e) {
      debugPrint(e.message);
    }
    throw Error();
  }

  static Future<LearningStaticModel> getLearningStaticWith(String id) async {
    try {
      Response response = await API.dio.get('/${Paths.learningRecord}/$id');

      final Map<String, dynamic> body = jsonDecode(utf8.decode(response.data));
      if (body["data"] != null) {
        return LearningStaticModel.fromJson(body["data"]);
      }
    } on DioException catch (e) {
      debugPrint(e.message);
    }
    throw Error();
  }

  static Future<String> saveLearningStatic(
      String id, LearningStaticModel learningResult) async {
    var data = json.encode(learningResult.toJson());

    try {
      Response response =
          await API.dio.post('/${Paths.learningRecord}/$id', data: data);

      final Map<String, dynamic> body = jsonDecode(utf8.decode(response.data));
      if (body["data"] != null) {
        return body["data"]["recordID"];
      }
    } on DioException catch (e) {
      debugPrint(e.message);
    }
    throw Error();
  }
}
