import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lipread/utilities/app_color_scheme.dart';
import 'package:lipread/utilities/font_type.dart';
import 'package:lipread/utilities/functions.dart';

import 'percentage_circular_indicator.dart';

class LearningStatics extends StatelessWidget {
  final int totalLearningTimeInMilliseconds;
  final int totalLearningCount;
  final double correctAnswerRatio;
  final String mostUncorrectedSentence;

  const LearningStatics({
    super.key,
    required this.totalLearningTimeInMilliseconds,
    required this.totalLearningCount,
    required this.correctAnswerRatio,
    required this.mostUncorrectedSentence,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 24,
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '평균 정답률',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      PercentangeCircularIndicator(correctAnswerRatio),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 24,
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '누적 학습 시간',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Text(
                            formatTotalLearningTimeWith(
                                totalLearningTimeInMilliseconds),
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: FontType.pretendard.name,
                              fontVariations: const [
                                FontVariation('wght', 700)
                              ],
                              color: AppColor.primaryColor,
                              height: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 24,
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '누적 학습 횟수',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Text(
                            '$totalLearningCount회',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: FontType.pretendard.name,
                              fontVariations: const [
                                FontVariation('wght', 700)
                              ],
                              color: AppColor.primaryColor,
                              height: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: 24,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                '가장 많이 틀린 문장',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                mostUncorrectedSentence,
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: FontType.pretendard.name,
                  fontVariations: const [FontVariation('wght', 700)],
                  color: AppColor.orangeColor,
                  height: 1.55,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
