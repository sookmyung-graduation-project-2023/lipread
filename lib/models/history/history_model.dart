class HistoryModel {
  final String id;
  final String emoji;
  final String title;

  HistoryModel({
    required this.id,
    required this.emoji,
    required this.title,
  });

  HistoryModel.fromJson(Map<String, dynamic> json)
      : id = json["recordID"],
        emoji = json["emoji"],
        title = json["title"];
}
