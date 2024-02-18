import 'package:lipread/models/message_check_model.dart';

class MessageModel {
  final String id;
  final String text;
  final String role;
  final String videoUrl;
  List<MessageCheckModel>? messageCheck;

  MessageModel.fromJson(Map<String, dynamic> json)
      : id = json["chatID"] ?? "none",
        text = json["text"] ?? "none",
        role = json["role"] ?? "none",
        videoUrl = json["videoUrl"] ?? "none";
}
