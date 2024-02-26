import 'package:lipread/models/history/history_model.dart';

class HistorysOfDayModel {
  final DateTime dateTime;
  late List<HistoryModel> historysOfDay;

  HistorysOfDayModel.fromJson(Map<String, dynamic> json)
      : dateTime = DateTime.fromMillisecondsSinceEpoch(json['day']) {
    for (var history in json["study"]) {
      historysOfDay.add(HistoryModel.fromJson(history));
    }
  }
}
