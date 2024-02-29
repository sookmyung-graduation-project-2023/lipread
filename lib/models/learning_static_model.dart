import 'package:lipread/models/wrong_sentence_model.dart';

class LearningStaticModel {
  final String? id;
  final String emoji;
  final String title;
  final int totalLearningTimeInMilliseconds;
  final double correctRate;
  late List<WrongSetenceModel> wrongSetences;

  int? learningSentenceCount;

  LearningStaticModel({
    this.id,
    required this.learningSentenceCount,
    required this.emoji,
    required this.title,
    required this.totalLearningTimeInMilliseconds,
    required this.correctRate,
    required this.wrongSetences,
  });

  LearningStaticModel.fromJson(Map<String, dynamic> json)
      : id = json["recordID"],
        emoji = json["emoji"],
        title = json["title"],
        totalLearningTimeInMilliseconds = json["study"]["totalTime"],
        correctRate = json["study"]["correctRate"].toDouble() {
    List<WrongSetenceModel> list = [];
    for (var item in json["study"]["sentenceList"]) {
      list.add(WrongSetenceModel.fromJson(item));
    }
    wrongSetences = list;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['title'] = title;
    data['emoji'] = emoji;
    data['sentenceCnt'] = learningSentenceCount;
    data['study'] = {
      'totalTime': totalLearningTimeInMilliseconds,
      'correctRate': correctRate,
      "sentenceList": [...wrongSetences.map((sentence) => sentence.toJson())]
    };
    return data;
  }
}
