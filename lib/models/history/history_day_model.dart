import 'package:lipread/models/history/history_model.dart';

class HistorysOfDayModel {
  final DateTime dateTime;
  final List<HistoryModel> historysOfDay = [];

  HistorysOfDayModel({
    required this.dateTime,
  });

  HistorysOfDayModel.fromJson(Map<String, dynamic> json)
      : dateTime = DateTime.fromMillisecondsSinceEpoch(json['date']) {
    for (var history in json["study"]) {
      historysOfDay.add(HistoryModel.fromJson(history));
    }
  }
}
