import 'package:lipread/models/wrong_sentence_model.dart';

class HistoryBasicModel {
  final String id;
  final String emoji;
  final String title;
  final int totalLearningTimeInMilliseconds;
  final double correctRate;
  late List<WrongSetenceModel> wrongSetences;

  HistoryBasicModel.fromJson(Map<String, dynamic> json)
      : id = json["recordID"],
        emoji = json["emoji"],
        title = json["title"],
        totalLearningTimeInMilliseconds = json["study"]["totatlTime"],
        correctRate = json["study"]["correctRate"] {
    List<WrongSetenceModel> list = [];
    for (var item in json["study"]["sentenceList"]) {
      list.add(WrongSetenceModel.fromJson(item));
    }
    wrongSetences = list;
  }
}
