class RecentTemplateModel {
  final String id;
  final String emoji;
  final String title;

  RecentTemplateModel({
    required this.id,
    required this.emoji,
    required this.title,
  });

  RecentTemplateModel.fromJson(Map<String, dynamic> json)
      : id = json["roleplayID"],
        emoji = json["emoji"],
        title = json["title"];
}
