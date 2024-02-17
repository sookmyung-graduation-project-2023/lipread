class UnOfficialTemplateModel {
  final String id;
  final String title;
  final String emoji;
  final String? originalTemplateName;

  UnOfficialTemplateModel.fromJson(Map<String, dynamic> json)
      : id = json["roleplayID"] ?? "none",
        title = json["title"] ?? "none",
        emoji = json["emoji"] ?? "none",
        originalTemplateName = json["parentTitle"];
}
