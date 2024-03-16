import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lipread/models/template/new_template_model.dart';

import 'package:lipread/models/template/official_template_model.dart';
import 'package:lipread/models/template/template_model.dart';
import 'package:lipread/models/template/unofficial_template_model.dart';
import 'package:lipread/services/api.dart';
import 'package:lipread/services/token_service.dart';
import 'package:lipread/utilities/variables.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class TemplateService {
  static const String roleplayList = 'roleplayList';
  static const String roleplay = 'roleplay';
  static const String official = 'official';
  static const String personal = 'personal';
  static const String newTopic = 'newTopic';

  static Future<List<OfficialTemplateModel>> getOfficialTemplates(
      {OfficialCategoryType category = OfficialCategoryType.all}) async {
    List<OfficialTemplateModel> officialTemplateInstances = [];

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString('accessToken')!;

    Map<String, String> headers = {
      HttpHeaders.authorizationHeader: "Bearer $accessToken",
    };

    final url = _getUriBy(category);

    final response = await http.get(url, headers: headers);
    if (response.statusCode == 401) {
      await TokenService.refreshAccessToken();
      getOfficialTemplates();
    } else if (response.statusCode == 200) {
      final Map<String, dynamic> body =
          jsonDecode(utf8.decode(response.bodyBytes));
      if (body["data"] != null) {
        for (var template in body["data"]) {
          officialTemplateInstances
              .add(OfficialTemplateModel.fromJson(template));
        }
      }
      return officialTemplateInstances;
    }
    throw Error();
  }

  static Uri _getUriBy(OfficialCategoryType category) {
    if (category == OfficialCategoryType.all) {
      return Uri.https(API.baseURL, '$roleplayList/$official');
    } else {
      final queryParameters = {
        'category': category.name,
      };
      return Uri.https(API.baseURL, '$roleplayList/$official', queryParameters);
    }
  }

  static Future<List<UnOfficialTemplateModel>> getUnOfficialTemplate() async {
    List<UnOfficialTemplateModel> unOfficialTemplateInstances = [];

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString('accessToken')!;

    Map<String, String> headers = {
      HttpHeaders.authorizationHeader: "Bearer $accessToken",
    };

    final url = Uri.https(API.baseURL, '$roleplayList/$personal');
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 401) {
      await TokenService.refreshAccessToken();
      getUnOfficialTemplate();
    } else if (response.statusCode == 200) {
      debugPrint('비공식 템플릿 가져오기');
      final Map<String, dynamic> body =
          jsonDecode(utf8.decode(response.bodyBytes));
      if (body["data"] != null) {
        for (var template in body["data"]) {
          unOfficialTemplateInstances
              .add(UnOfficialTemplateModel.fromJson(template));
        }
      }
      return unOfficialTemplateInstances;
    }
    throw Error();
  }

  static WebSocketChannel subscribeUnOfficialTemplate() {
    final wsUrl = Uri.parse(
        'wss://6ppmb67186.execute-api.ap-northeast-2.amazonaws.com/production/?userID=u12345678');
    return WebSocketChannel.connect(wsUrl);
  }

  static Future<TemplateModel> getTemplateDescriptionBy(String id) async {
    debugPrint('id:: $id');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString('accessToken')!;

    Map<String, String> headers = {
      HttpHeaders.authorizationHeader: "Bearer $accessToken",
    };

    final url = Uri.https(API.baseURL, '$roleplay/$id');
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 401) {
      await TokenService.refreshAccessToken();
      getTemplateDescriptionBy(id);
    } else if (response.statusCode == 200) {
      final Map<String, dynamic> body =
          jsonDecode(utf8.decode(response.bodyBytes));
      if (body["data"] != null) {
        TemplateModel templateInstance = TemplateModel.fromJson(body["data"]);
        return templateInstance;
      }
    }
    throw Error();
  }

  static Stream<String> createNewTemplate2() async* {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString('accessToken')!;

    Map<String, String> headers = {
      HttpHeaders.authorizationHeader: "Bearer $accessToken",
    };

    var body = json.encode({
      "title": "카페에서 아이스 아메리카노 주문하기",
      "description": "카페에서 손님이 음료를 주문한다.",
      "role1": "카페 직원",
      "role1Desc": "카운터에서 카페 주문하는 손님을 응대한다.",
      "role1Type": "woman",
      "role2": "손님",
      "role2Desc": "카페에서 음료를 주문하려고 한다. ",
      "role2Type": "man",
      "mustWords": ["아이스아메리카노", "바닐라라떼"]
    });

    final url = Uri.https(API.createNewTopicBaseURL, '$roleplay/$newTopic');
    final response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    if (response.statusCode == 401) {
      await TokenService.refreshAccessToken();
      createNewTemplate2();
    } else if (response.statusCode == 201) {
      final String utf8Decoded =
          utf8.decode(response.bodyBytes).replaceAll('data: ', '');
      final Map<String, dynamic> body = jsonDecode(utf8Decoded);
      yield body.toString();
    }
  }

  static Future<http.StreamedResponse> createNewTemplate(
      NewTemplateModel template) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString('accessToken')!;

    http.Client client = http.Client();

    final url = Uri.https(API.createNewTopicBaseURL, '$roleplay/$newTopic');

    var body = json.encode(template.toJson());

    var request = http.Request("POST", url);

    request.headers['authorization'] = "Bearer $accessToken";
    request.headers['accept'] = "text/event-stream";

    request.body = body;

    Future<http.StreamedResponse> response = client.send(request);
    return response;
/*
    if (response.statusCode == 401) {
      await TokenService.refreshAccessToken();
      createNewTemplate();
    } else if (response.statusCode == 201) {
      final String utf8Decoded =
          utf8.decode(response.bodyBytes).replaceAll('data: ', '');
      final Map<String, dynamic> body = jsonDecode(utf8Decoded);
      yield body.toString();
    }*/
  }
}
