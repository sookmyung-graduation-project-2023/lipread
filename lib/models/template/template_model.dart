import 'package:lipread/models/template/template_learning_static_model.dart';
import 'package:lipread/models/role_model.dart';
import 'package:lipread/utilities/variables.dart';

class TemplateModel {
  final String id;
  final String title;
  final String emoji;
  final String explain;
  final RoleModel firstRole;
  final RoleModel secondRole;
  OfficialCategoryType? officialCategory;
  String? originalTemplateName;
  TemplateLearningStaticModel? learningStatics;

  TemplateModel.fromJson(Map<String, dynamic> json)
      : id = json["roleplayID"],
        title = json["title"],
        emoji = json["emoji"],
        explain = json["description"],
        firstRole = RoleModel(
          name: json["role1"],
          explain: json["role1Desc"],
          type: RoleType.values.byName(json["role1Type"]),
        ),
        secondRole = RoleModel(
          name: json["role2"],
          explain: json["role2Desc"],
          type: RoleType.values.byName(json["role2Type"]),
        ),
        officialCategory = json["category"] != null
            ? OfficialCategoryType.values.byName(json["category"])
            : null,
        originalTemplateName = json["parentTitle"],
        learningStatics = json.containsKey('study')
            ? TemplateLearningStaticModel.fromJson(json["study"])
            : null;
}
