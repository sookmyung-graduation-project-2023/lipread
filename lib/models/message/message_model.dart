import 'package:lipread/models/message/message_check_model.dart';
import 'package:lipread/models/message/message_checks_model.dart';
import 'package:lipread/models/wrong_sentence_model.dart';
import 'package:lipread/utilities/variables.dart';

class MessageModel {
  final String id;
  final RoleType roleType;
  final String text;
  final String role;
  final String videoUrl;

  LearningStateType learningStateType = LearningStateType.beforeRecorded;

  MessageChecksModel? checkInformation;

  MessageModel.fromJson(Map<String, dynamic> json)
      : id = json["chatID"] ?? "none",
        text = json["text"] ?? "none",
        roleType = getRoleTypeWith(json["roleType"]),
        role = json["role"] ?? "none",
        videoUrl = json["videoUrl"] ?? "none";

  WrongSetenceModel getWrongSetence() {
    if (checkInformation != null) {
      return WrongSetenceModel(
        type: roleType,
        name: role,
        sentence: text,
        checked: checkInformation!.messageCheck,
      );
    }
    throw Error();
  }
}
