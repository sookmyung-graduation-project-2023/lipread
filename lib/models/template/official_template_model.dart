class OfficialTemplateModel {
  final String id;
  final String title;
  final String emoji;

  OfficialTemplateModel.fromJson(Map<String, dynamic> json)
      : id = json["roleplayID"] ?? "none",
        title = json["title"] ?? "none",
        emoji = json["emoji"] ?? "none";
}
