class CreatingTemplateModel {
  final String id;
  final String title;
  final int percentage;
  final String status;
  String? parentTitle;

  CreatingTemplateModel.fromJson(Map<String, dynamic> json)
      : id = json["roleplayID"],
        title = json["title"],
        percentage = json["percentage"],
        status = json["status"],
        parentTitle = json["parentTitle"];
}
