import 'package:lipread/utilities/variables.dart';

class WrongSetenceModel {
  final RoleType type;
  final String name;
  final String sentence;

  WrongSetenceModel.fromJson(Map<String, dynamic> json)
      : type = json["role"],
        name = json["roleName"],
        sentence = json["sentence"];
}
