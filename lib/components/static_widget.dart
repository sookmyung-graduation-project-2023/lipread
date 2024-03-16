import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lipread/utilities/app_color_scheme.dart';
import 'package:lipread/utilities/font_type.dart';

class StaticWidget extends StatelessWidget {
  final String title;
  final String value;

  const StaticWidget({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
            title,
            style: Theme.of(context).textTheme.titleSmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontFamily: FontType.pretendard.name,
              fontVariations: const [FontVariation('wght', 700)],
              color: AppColor.primaryColor,
              height: 1,
            ),
          ),
        ],
      ),
    );
  }
}
