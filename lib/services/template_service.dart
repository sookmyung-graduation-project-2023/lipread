import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:lipread/models/template/new_template_model.dart';

import 'package:lipread/models/template/official_template_model.dart';
import 'package:lipread/models/template/template_model.dart';
import 'package:lipread/models/template/unofficial_template_model.dart';

import 'package:lipread/services/api.dart';
import 'package:lipread/utilities/variables.dart';

class TemplateService {
  static Future<List<OfficialTemplateModel>> getOfficialTemplates(
      {OfficialCategoryType category = OfficialCategoryType.all}) async {
    final List<OfficialTemplateModel> officialTemplateInstances = [];
    final queryParameters = {
      'category': category.name,
    };

    try {
      Response response = category == OfficialCategoryType.all
          ? await API.dio.get('/${Paths.roleplayList}/${Paths.official}')
          : await API.dio.get('/${Paths.roleplayList}/${Paths.official}',
              queryParameters: queryParameters);

      final Map<String, dynamic> body = jsonDecode(utf8.decode(response.data));
      if (body["data"] != null) {
        for (var template in body["data"]) {
          officialTemplateInstances
              .add(OfficialTemplateModel.fromJson(template));
        }
      }
      return officialTemplateInstances;
    } on DioException catch (e) {
      debugPrint(e.message);
    }
    throw Error();
  }

  static Future<List<UnOfficialTemplateModel>> getUnOfficialTemplate() async {
    final List<UnOfficialTemplateModel> unOfficialTemplateInstances = [];

    try {
      Response response =
          await API.dio.get('/${Paths.roleplayList}/${Paths.personal}');
      final Map<String, dynamic> body = jsonDecode(utf8.decode(response.data));
      if (body["data"] != null) {
        for (var template in body["data"]) {
          unOfficialTemplateInstances
              .add(UnOfficialTemplateModel.fromJson(template));
        }
      }
      return unOfficialTemplateInstances;
    } on DioException catch (e) {
      debugPrint("exception: ${e.message}");
    }
    throw Error();
  }

  static Future<TemplateModel> getTemplateDescriptionBy(String id) async {
    try {
      Response response = await API.dio.get('/${Paths.roleplay}/$id');
      final Map<String, dynamic> body = jsonDecode(utf8.decode(response.data));
      if (body["data"] != null) {
        return TemplateModel.fromJson(body["data"]);
      }
    } on DioException catch (e) {
      debugPrint(e.message);
    }
    throw Error();
  }

  static Future<void> createNewTemplate(NewTemplateModel template) async {
    final data = json.encode(template.parentTemplateId == null
        ? template.toNewTemplateJson()
        : template.toLearnedTemplateJson());

    try {
      Response response = await API.dio.post(
        template.parentTemplateId == null
            ? '/${Paths.roleplay}/${Paths.newTopic}'
            : '${Paths.roleplay}/${Paths.usedTopic}',
        data: data,
      );

      final Map<String, dynamic> body = jsonDecode(utf8.decode(response.data));
      if (body["data"] != null) {
        return;
      }
    } on DioException catch (e) {
      debugPrint(e.message);
    }
    throw Error();
  }
}
