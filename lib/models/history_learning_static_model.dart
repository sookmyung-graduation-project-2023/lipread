class HistoryLearningStaticModel {
  final int totalLearningTimeInMilliseconds;
  final int totalLearningSentenceCount;

  HistoryLearningStaticModel({
    required this.totalLearningTimeInMilliseconds,
    required this.totalLearningSentenceCount,
  });

  HistoryLearningStaticModel.fromJson(Map<String, dynamic> json)
      : totalLearningTimeInMilliseconds = json["totatlTime"],
        totalLearningSentenceCount = json["sentenceCnt"];
}
