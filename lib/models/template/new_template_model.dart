import 'package:lipread/models/role_model.dart';

class NewTemplateModel {
  final String title;
  final String description;
  final RoleModel firstRole;
  final RoleModel secondRole;
  final List<String> words;

  NewTemplateModel(
      {required this.title,
      required this.description,
      required this.firstRole,
      required this.secondRole,
      required this.words});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    data['title'] = title;
    data['description'] = description;
    data['role1'] = firstRole.name;
    data['role2Type'] = firstRole.type.name;
    data['role1Desc'] = firstRole.explain;
    data['role2'] = secondRole.name;
    data['role2Type'] = secondRole.type.name;
    data['role2Desc'] = secondRole.explain;
    data['mustWords'] = words;

    return data;
  }
}
