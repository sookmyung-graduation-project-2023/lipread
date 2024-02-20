import 'package:flutter/material.dart';
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

  final void Function()? onPressedRerecord;
  final void Function()? onPressedCheck;
  final void Function()? onPressedComplete;

  const MessageCard({
    super.key,
    required this.id,
    required this.role,
    required this.text,
    required this.videoUrl,
    this.learningStateType = LearningStateType.beforeRecorded,
    this.onPressedRerecord,
    this.onPressedCheck,
    this.onPressedComplete,
  });

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
                    Text(
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
