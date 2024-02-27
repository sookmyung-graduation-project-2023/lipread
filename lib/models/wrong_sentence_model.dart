import 'package:lipread/models/message/message_check_model.dart';
import 'package:lipread/utilities/variables.dart';

class WrongSetenceModel {
  final RoleType type;
  final String name;
  late List<MessageCheckModel> sentence;

  WrongSetenceModel.fromJson(Map<String, dynamic> json)
      : type = getRoleTypeWith(json["roleType"]),
        name = json["role"] {
    final List<MessageCheckModel> list = [];
    for (var check in json["check"]) {
      list.add(MessageCheckModel(
        code: getMessageCodeWith(check[0]),
        text: check[1],
      ));
    }
    sentence = list;
  }
}
