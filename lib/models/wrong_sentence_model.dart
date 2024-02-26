import 'package:lipread/models/message/message_check_model.dart';
import 'package:lipread/utilities/variables.dart';

class WrongSetenceModel {
  final RoleType type;
  final String name;
  final List<MessageCheckModel> sentence;

  WrongSetenceModel.fromJson(Map<String, dynamic> json)
      : type = json["roleType"],
        name = json["role"],
        sentence = json["check"];
}
