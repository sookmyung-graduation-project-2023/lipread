import 'package:lipread/models/role_model.dart';

class NewTemplateModel {
  late String title;
  late String description;
  late RoleModel firstRole;
  late RoleModel secondRole;
  late List<String> words;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['title'] = title;
    data['description'] = description;
    data['role1'] = firstRole.name;
    data['role1Desc'] = firstRole.explain;
    data['role1Type'] = firstRole.type.name;
    data['role2'] = secondRole.name;
    data['role2Desc'] = secondRole.explain;
    data['role2Type'] = secondRole.type.name;
    data['mustWords'] = words;

    return data;
  }
}
