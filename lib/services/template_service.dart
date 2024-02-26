import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:lipread/models/template/official_template_model.dart';
import 'package:lipread/models/template/template_model.dart';
import 'package:lipread/models/template/unofficial_template_model.dart';
import 'package:lipread/services/api.dart';
import 'package:lipread/services/token_service.dart';
import 'package:lipread/utilities/variables.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TemplateService {
  static const String roleplayList = 'roleplayList';
  static const String roleplay = 'roleplay';
  static const String official = 'official';
  static const String personal = 'personal';

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

  static Future<TemplateModel> getTemplateDescriptionBy(String id) async {
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
}
