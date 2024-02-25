class HistoryDayModel {
  final String id;
  final String emoji;
  final String title;

  HistoryDayModel({
    required this.id,
    required this.emoji,
    required this.title,
  });

  HistoryDayModel.fromJson(Map<String, dynamic> json)
      : id = json["recordID"],
        emoji = json["emoji"],
        title = json["title"];
}
