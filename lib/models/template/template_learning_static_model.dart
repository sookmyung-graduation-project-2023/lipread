class TemplateLearningStaticModel {
  final int totalLearningTimeInMilliseconds;
  final int totalLearningCount;
  final double correctAnswerRatio;
  final String mostUncorrectedSentence;

  TemplateLearningStaticModel({
    required this.totalLearningTimeInMilliseconds,
    required this.totalLearningCount,
    required this.correctAnswerRatio,
    required this.mostUncorrectedSentence,
  });

  TemplateLearningStaticModel.fromJson(Map<String, dynamic> json)
      : totalLearningTimeInMilliseconds = json["totatlTime"],
        totalLearningCount = json["learnCnt"],
        correctAnswerRatio = json["correctRate"].toDouble(),
        mostUncorrectedSentence = json["sentence"];
}
