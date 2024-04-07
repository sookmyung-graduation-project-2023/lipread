import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lipread/utilities/app_color_scheme.dart';
import 'package:lipread/utilities/font_type.dart';

class BaseAlertDialog extends StatelessWidget {
  final String title;
  final String description;
  final List<Widget> actions;

  const BaseAlertDialog({
    super.key,
    required this.title,
    required this.description,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 36),
      titlePadding: const EdgeInsets.only(
        top: 36,
        right: 24,
        left: 24,
      ),
      contentPadding: const EdgeInsets.only(
        top: 12,
        right: 24,
        left: 24,
      ),
      actionsPadding: const EdgeInsets.only(
        top: 40,
        right: 24,
        left: 24,
        bottom: 12,
      ),
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 18,
          fontFamily: FontType.pretendard.name,
          fontVariations: const [FontVariation('wght', 700)],
          color: AppColor.grayScale.g900,
        ),
      ),
      content: Text(
        description,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      actions: actions,
    );
  }
}
