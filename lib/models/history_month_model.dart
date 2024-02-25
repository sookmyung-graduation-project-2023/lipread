import 'package:lipread/models/history_day_model.dart';

class HistoryMonthModel {
  final int day;
  final List<HistoryDayModel> historysOfDay = [];

  HistoryMonthModel.fromJson(Map<String, dynamic> json) : day = json["day"] {
    for (var history in json["study"]) {
      historysOfDay.add(HistoryDayModel.fromJson(history));
    }
  }
}
