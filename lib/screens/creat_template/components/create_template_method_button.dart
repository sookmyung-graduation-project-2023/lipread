import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:lipread/screens/creat_template/screens/template_title_input_screen.dart';
import 'package:lipread/utilities/app_color_scheme.dart';
import 'package:lipread/utilities/font_type.dart';

class CreateTemplateMethodButton extends StatelessWidget {
  final void Function() onPressed;
  final Widget child;
  final bool isSelected;

  const CreateTemplateMethodButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        minimumSize: const Size(0, 0),
        padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 16),
        foregroundColor:
            isSelected ? AppColor.primaryColor : AppColor.grayScale.g600,
        backgroundColor:
            isSelected ? AppColor.primaryLightColor : Colors.transparent,
        shape: RoundedRectangleBorder(
          side: BorderSide(
              color:
                  isSelected ? AppColor.primaryColor : AppColor.grayScale.g200),
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: TextStyle(
          fontFamily: FontType.pretendard.name,
          fontSize: 14,
          height: 1.55,
          fontVariations: [
            isSelected
                ? const FontVariation('wght', 600)
                : const FontVariation('wght', 500),
          ],
        ),
      ),
      child: child,
    );
  }
}
