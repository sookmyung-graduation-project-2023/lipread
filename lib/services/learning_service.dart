import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:lipread/models/message_check_model.dart';
import 'package:lipread/models/message_model.dart';
import 'package:lipread/services/api.dart';
import 'package:lipread/services/token_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LearningService {
  static const String roleplay = 'roleplay';
  static const String chatList = 'chatList';
  static const String checkChat = 'checkChat';

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

  static Future<List<MessageCheckModel>> checkMessageWith(
      String input, String answer) async {
    List<MessageCheckModel> messageCheckInstances = [];

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString('accessToken')!;

    Map<String, String> headers = {
      HttpHeaders.authorizationHeader: "Bearer $accessToken",
    };

    Map<String, String> body = {
      "input": input,
      "answer": answer,
    };

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
          messageCheckInstances.add(MessageCheckModel(
            code: messageCheck[0],
            text: messageCheck[1],
          ));
        }
      }
      return messageCheckInstances;
    }
    throw Error();
  }
}
