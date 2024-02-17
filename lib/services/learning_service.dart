import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:lipread/models/message_model.dart';
import 'package:lipread/services/api.dart';
import 'package:lipread/services/token_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LearningService {
  static const String roleplay = 'roleplay';
  static const String chatList = 'chatList';

  static Future<List<MessageModel>> getMessagesBy(String id) async {
    List<MessageModel> messagesInstances = [];

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString('accessToken')!;

    Map<String, String> headers = {
      HttpHeaders.authorizationHeader: "Bearer $accessToken",
    };

    final url = Uri.parse('${API.baseURL}/$roleplay/$chatList/$id');
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
}