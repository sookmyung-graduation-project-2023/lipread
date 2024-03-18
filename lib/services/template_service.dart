import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lipread/exceptions/refresh_fail_exception.dart';
import 'package:lipread/models/template/new_template_model.dart';

import 'package:lipread/models/template/official_template_model.dart';
import 'package:lipread/models/template/template_model.dart';
import 'package:lipread/models/template/unofficial_template_model.dart';
import 'package:lipread/providers/sharedpreferences_provider.dart';
import 'package:lipread/providers/token_provider.dart';
import 'package:lipread/services/api.dart';
import 'package:lipread/services/token_service.dart';
import 'package:lipread/utilities/variables.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class TemplateService {
  static Future<List<OfficialTemplateModel>> getOfficialTemplates(
      TokenProvider tokenProvider,
      {OfficialCategoryType category = OfficialCategoryType.all}) async {
    List<OfficialTemplateModel> officialTemplateInstances = [];
    String? accessToken = await tokenProvider.getAccessToken();

    int retryCount = 0;

    do {
      Map<String, String> headers = {
        HttpHeaders.authorizationHeader: "Bearer $accessToken",
      };

      final url = _getUriBy(category);
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 401) {
        await TokenService.refreshAccessToken();
        accessToken = await tokenProvider.getAccessToken();
        retryCount++;
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
    } while (retryCount < API.maxTokenRefreshTries);

    throw RefreshFailException();
  }

  static Uri _getUriBy(OfficialCategoryType category) {
    if (category == OfficialCategoryType.all) {
      return Uri.https(API.baseURL, '${API.roleplayList}/${API.official}');
    } else {
      final queryParameters = {
        'category': category.name,
      };
      return Uri.https(
          API.baseURL, '${API.roleplayList}/${API.official}', queryParameters);
    }
  }

  static Future<List<UnOfficialTemplateModel>> getUnOfficialTemplate() async {
    List<UnOfficialTemplateModel> unOfficialTemplateInstances = [];

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accessToken');

    Map<String, String> headers = {
      HttpHeaders.authorizationHeader: "Bearer $accessToken",
    };

    final url = Uri.https(API.baseURL, '${API.roleplayList}/${API.personal}');
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
    throw RefreshFailException();
  }

  static WebSocketChannel subscribeUnOfficialTemplate(
      String? userId, String? deviceToken) {
    return WebSocketChannel.connect(Uri.parse(
        '${API.websocktURL}/?userID=$userId&deviceToken=$deviceToken'));
  }

  static Future<TemplateModel> getTemplateDescriptionBy(String id) async {
    debugPrint('id:: $id');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString('accessToken')!;

    Map<String, String> headers = {
      HttpHeaders.authorizationHeader: "Bearer $accessToken",
    };

    final url = Uri.https(API.baseURL, '${API.roleplay}/$id');
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

  static Future<void> createNewTemplate(NewTemplateModel template) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString('accessToken')!;

    Map<String, String> headers = {
      HttpHeaders.authorizationHeader: "Bearer $accessToken",
    };

    var body = json.encode(template.parentTemplateId == null
        ? template.toNewTemplateJson()
        : template.toLearnedTemplateJson());

    final url = Uri.https(
        API.baseURL,
        template.parentTemplateId == null
            ? '${API.roleplay}/${API.newTopic}'
            : '${API.roleplay}/${API.usedTopic}');
    final response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    if (response.statusCode == 401) {
      await TokenService.refreshAccessToken();
      createNewTemplate(template);
    } else if (response.statusCode == 201) {
      final Map<String, dynamic> body =
          jsonDecode(utf8.decode(response.bodyBytes));
      return;
    }
    throw Error();
  }
}
