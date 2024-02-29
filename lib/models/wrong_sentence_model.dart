import 'package:lipread/models/message/message_check_model.dart';
import 'package:lipread/utilities/variables.dart';

class WrongSetenceModel {
  final RoleType type;
  final String name;
  late List<MessageCheckModel> checked;
  String? sentence;

  WrongSetenceModel({
    required this.type,
    required this.name,
    required this.sentence,
    required this.checked,
  });

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
    checked = list;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['roleType'] = type.name;
    data['role'] = name;
    data['sentence'] = sentence;
    data['check'] = [...checked.map((check) => check.toList())];
    return data;
  }
}
