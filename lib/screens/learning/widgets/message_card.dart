import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lipread/models/message_check_model.dart';
import 'package:lipread/utilities/app_color_scheme.dart';
import 'package:lipread/utilities/font_type.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:lipread/utilities/variables.dart';

class MessageCard extends StatelessWidget {
  final int id;
  final String role;
  final String text;
  final String videoUrl;
  final LearningStateType learningStateType;
  final List<MessageCheckModel>? messageCheck;

  final void Function()? onPressedRerecord;
  final void Function()? onPressedCheck;
  final void Function()? onPressedComplete;

  MessageCard({
    super.key,
    required this.id,
    required this.role,
    required this.text,
    required this.videoUrl,
    required this.learningStateType,
    this.onPressedRerecord,
    this.onPressedCheck,
    this.onPressedComplete,
    this.messageCheck,
  });

  List<Widget> getMessageCheckedTexts() {
    List<Widget> listOfWidgets = [];
    if (messageCheck == null) {
      return listOfWidgets;
    }
    for (var check in messageCheck!) {
      if (check.code == MessageCodeType.wrong) {
        listOfWidgets.add(Text(
          check.text,
          style: wrongTextStyle,
        ));
      } else if (check.code == MessageCodeType.answer) {
        listOfWidgets.add(Text(
          check.text,
          style: answerTextStyle,
        ));
      } else if (check.code == MessageCodeType.correct) {
        listOfWidgets.add(Text(
          check.text,
          style: correctTextStyle,
        ));
      }
    }

    return listOfWidgets;
  }

  var wrongTextStyle = TextStyle(
    fontSize: 16,
    fontFamily: FontType.pretendard.name,
    fontVariations: const [FontVariation('wght', 500)],
    color: AppColor.orangeColor,
    height: 1.55,
    decoration: TextDecoration.lineThrough,
    decorationColor: AppColor.orangeColor,
  );

  var correctTextStyle = TextStyle(
    fontSize: 16,
    fontFamily: FontType.pretendard.name,
    fontVariations: const [FontVariation('wght', 500)],
    color: AppColor.grayScale.g800,
    height: 1.55,
  );

  var answerTextStyle = TextStyle(
    fontSize: 16,
    fontFamily: FontType.pretendard.name,
    fontVariations: const [FontVariation('wght', 500)],
    color: AppColor.primaryColor,
    height: 1.55,
  );

  @override
  Widget build(BuildContext context) {
    var smallTextButtonPrimaryColorStyle = TextButton.styleFrom(
      minimumSize: const Size(0, 0),
      padding: const EdgeInsets.symmetric(vertical: 16),
      backgroundColor: AppColor.primaryLightColor,
      foregroundColor: AppColor.primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          width: 1,
          color: AppColor.grayScale.g200,
        ),
      ),
      textStyle: TextStyle(
        fontFamily: FontType.pretendard.name,
        fontSize: 16,
        height: 1,
        fontVariations: const [
          FontVariation('wght', 500),
        ],
      ),
    );

    var smallTextButtonGrayStyle = TextButton.styleFrom(
      minimumSize: const Size(0, 0),
      padding: const EdgeInsets.symmetric(vertical: 16),
      backgroundColor: AppColor.grayScale.g100,
      foregroundColor: AppColor.grayScale.g600,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          width: 1,
          color: AppColor.grayScale.g200,
        ),
      ),
      textStyle: TextStyle(
        fontFamily: FontType.pretendard.name,
        fontSize: 16,
        height: 1,
        fontVariations: const [
          FontVariation('wght', 500),
        ],
      ),
    );
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 24,
          ),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(12),
            ),
            border: Border.all(
              width: 1,
              color: AppColor.grayScale.g200,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('🎢'),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      role,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    learningStateType == LearningStateType.corrected ||
                            learningStateType == LearningStateType.completed
                        ? Wrap(
                            spacing: 0,
                            runSpacing: 0,
                            direction: Axis.horizontal,
                            alignment: WrapAlignment.start,
                            children: getMessageCheckedTexts(),
                          )
                        : Text(
                            text,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                    DottedLine(
                      lineLength: double.infinity,
                      lineThickness: 1,
                      dashLength: 2,
                      dashColor: AppColor.grayScale.g400,
                      dashGapLength: 2,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        if (learningStateType == LearningStateType.recorded ||
            learningStateType == LearningStateType.corrected)
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 12,
              ),
              if (learningStateType == LearningStateType.recorded)
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: onPressedRerecord,
                        style: smallTextButtonGrayStyle,
                        child: const Text(
                          '다시 녹음',
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: onPressedCheck,
                        style: smallTextButtonPrimaryColorStyle,
                        child: const Text('정답 확인'),
                      ),
                    ),
                  ],
                ),
              if (learningStateType == LearningStateType.corrected)
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: onPressedComplete,
                        style: smallTextButtonPrimaryColorStyle,
                        child: const Text('다음으로'),
                      ),
                    ),
                  ],
                ),
            ],
          )
      ],
    );
  }
}

class SmallTag extends StatelessWidget {
  final String text;

  const SmallTag(
    this.text, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 6,
        horizontal: 8,
      ),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(100),
        ),
        border: Border.all(
          width: 1,
          color: AppColor.primaryColor,
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          fontFamily: FontType.pretendard.name,
          fontVariations: const [FontVariation('wght', 600)],
          color: AppColor.primaryColor,
          height: 1,
        ),
      ),
    );
  }
}
