import 'package:lipread/models/role_model.dart';

class NewTemplateModel {
  late String title;
  String? description;
  RoleModel? firstRole;
  RoleModel? secondRole;
  late List<String> words;
  String? parentTemplateId;

  Map<String, dynamic> toLearnedTemplateJson() {
    final Map<String, dynamic> data = {};
    data['title'] = title;
    data['parentRoleplayID'] = parentTemplateId;
    data['mustWords'] = words;

    return data;
  }

  Map<String, dynamic> toNewTemplateJson() {
    final Map<String, dynamic> data = {};
    data['title'] = title;
    data['description'] = description;
    data['role1'] = firstRole!.name;
    data['role1Desc'] = firstRole!.explain;
    data['role1Type'] = firstRole!.type.name;
    data['role2'] = secondRole!.name;
    data['role2Desc'] = secondRole!.explain;
    data['role2Type'] = secondRole!.type.name;
    data['mustWords'] = words;

    return data;
  }
}
