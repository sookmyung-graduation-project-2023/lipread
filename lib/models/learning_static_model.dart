class LearningStaticModel {
  final int totalLearningTimeInMilliseconds;
  final int totalLearningCount;
  final double correctAnswerRatio;
  final String mostUncorrectedSentence;

  LearningStaticModel({
    required this.totalLearningTimeInMilliseconds,
    required this.totalLearningCount,
    required this.correctAnswerRatio,
    required this.mostUncorrectedSentence,
  });

  LearningStaticModel.fromJson(Map<String, dynamic> json)
      : totalLearningTimeInMilliseconds = json["totatlTime"],
        totalLearningCount = json["learnCnt"],
        correctAnswerRatio = json["correctRate"].toDouble(),
        mostUncorrectedSentence = json["sentence"];
}
