import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lipread/utilities/app_color_scheme.dart';
import 'package:lipread/utilities/font_type.dart';
import 'package:lipread/utilities/variables.dart';

class ModalBottomSheet extends StatefulWidget {
  final String emoji;
  final String title;
  final String description;

  final String actionButtonText;
  final String backButtonText;

  final Color actionButtonColor;

  final void Function() actionButtonOnPressed;
  final void Function() backButtonOnPressed;

  const ModalBottomSheet({
    Key? key,
    required this.emoji,
    required this.title,
    required this.description,
    required this.actionButtonText,
    required this.backButtonText,
    this.actionButtonColor = AppColor.primaryColor,
    required this.actionButtonOnPressed,
    required this.backButtonOnPressed,
  }) : super(key: key);

  @override
  State<ModalBottomSheet> createState() => _ModalBottomSheetState();
}

class _ModalBottomSheetState extends State<ModalBottomSheet>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    animationController = BottomSheet.createAnimationController(this);
    animationController
      ..addListener(() {})
      ..duration = const Duration(milliseconds: 500)
      ..reverseDuration = const Duration(milliseconds: 500);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter bottomState) {
      return Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 44,
          horizontal: 24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  widget.emoji,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 52,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  widget.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: FontType.pretendard.name,
                    fontVariations: const [FontVariation('wght', 600)],
                    color: AppColor.grayScale.g900,
                    height: 1.55,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  widget.description,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            Column(
              children: [
                TextButton(
                  onPressed: widget.actionButtonOnPressed,
                  style: TextButton.styleFrom(
                      backgroundColor: widget.actionButtonColor),
                  child: Text(widget.actionButtonText),
                ),
                const SizedBox(
                  height: 6,
                ),
                TextButton(
                  onPressed: widget.backButtonOnPressed,
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      foregroundColor: AppColor.grayScale.g600),
                  child: Text(widget.backButtonText),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
