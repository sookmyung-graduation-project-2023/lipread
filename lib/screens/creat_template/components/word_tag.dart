import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lipread/utilities/app_color_scheme.dart';
import 'package:lipread/utilities/font_type.dart';

class WordTag extends StatelessWidget {
  final String word;
  final void Function() onPressed;
  const WordTag({
    super.key,
    required this.word,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        minimumSize: const Size(0, 0),
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 18,
        ),
        backgroundColor: Colors.transparent,
        foregroundColor: AppColor.grayScale.g700,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
          side: BorderSide(
            width: 1,
            color: AppColor.grayScale.g300,
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
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(word),
          const SizedBox(
            width: 12,
          ),
          Image.asset(
            'assets/icons/ic_close_small.png',
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }
}
