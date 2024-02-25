import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:lipread/utilities/app_color_scheme.dart';
import 'package:lipread/utilities/font_type.dart';

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
        horizontal: 10,
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
