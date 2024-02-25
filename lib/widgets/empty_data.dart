import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lipread/utilities/app_color_scheme.dart';
import 'package:lipread/utilities/font_type.dart';

class EmptyData extends StatelessWidget {
  final String text;
  const EmptyData({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 60,
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontFamily: FontType.pretendard.name,
            fontVariations: const [FontVariation('wght', 500)],
            color: AppColor.grayScale.g500,
            height: 1,
          ),
        ),
      ),
    );
  }
}
