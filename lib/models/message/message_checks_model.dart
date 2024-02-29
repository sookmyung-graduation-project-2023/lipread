import 'package:lipread/models/message/message_check_model.dart';

class MessageChecksModel {
  final bool isCorrect;
  final List<MessageCheckModel> messageCheck;

  MessageChecksModel({
    required this.isCorrect,
    required this.messageCheck,
  });
}
