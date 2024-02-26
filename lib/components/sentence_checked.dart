import 'package:flutter/material.dart';
import 'package:lipread/main.dart';
import 'package:lipread/models/message/message_check_model.dart';
import 'package:lipread/utilities/variables.dart';

class SentenceChecked extends StatelessWidget {
  final List<MessageCheckModel>? messageCheck;

  const SentenceChecked({super.key, required this.messageCheck});

  List<Widget> getMessageCheckedTexts(BuildContext context) {
    List<Widget> listOfCheckedWords = [];
    if (messageCheck == null) {
      return listOfCheckedWords;
    }
    for (var check in messageCheck!) {
      if (check.code == MessageCodeType.wrong) {
        listOfCheckedWords.add(Text(
          check.text,
          style: Theme.of(context).textTheme.wrongWord,
        ));
      } else if (check.code == MessageCodeType.answer) {
        listOfCheckedWords.add(Text(
          check.text,
          style: Theme.of(context).textTheme.answerWord,
        ));
      } else if (check.code == MessageCodeType.correct) {
        listOfCheckedWords.add(Text(
          check.text,
          style: Theme.of(context).textTheme.correctWord,
        ));
      }
    }

    return listOfCheckedWords;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 0,
      runSpacing: 0,
      direction: Axis.horizontal,
      alignment: WrapAlignment.start,
      children: getMessageCheckedTexts(context),
    );
  }
}
