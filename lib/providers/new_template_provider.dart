import 'package:flutter/material.dart';
import 'package:lipread/models/role_model.dart';
import 'package:lipread/models/template/new_template_model.dart';

class NewTemplateProvider with ChangeNotifier {
  late final NewTemplateModel _newTemplate = NewTemplateModel();

  NewTemplateModel get newTemplate => _newTemplate;

  set title(String title) {
    _newTemplate.title = title;
  }

  set description(String description) {
    _newTemplate.description = description;
  }

  set firstRole(RoleModel firstRole) {
    _newTemplate.firstRole = firstRole;
  }

  set secondRole(RoleModel secondRole) {
    _newTemplate.secondRole = secondRole;
  }

  set words(List<String> words) {
    _newTemplate.words = words;
  }
}
