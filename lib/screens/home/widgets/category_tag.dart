import 'package:flutter/material.dart';
import 'package:lipread/utilities/app_color_scheme.dart';
import 'package:lipread/utilities/font_type.dart';

class CagegoryTag extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final bool isSelected;

  const CagegoryTag({
    super.key,
    required this.onPressed,
    required this.text,
    required this.isSelected,
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
        backgroundColor:
            isSelected ? AppColor.primaryLightColor : Colors.transparent,
        foregroundColor:
            isSelected ? AppColor.primaryColor : AppColor.grayScale.g700,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
          side: BorderSide(
            width: 1,
            color: isSelected ? AppColor.primaryColor : AppColor.grayScale.g300,
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
      child: Text(text),
    );
  }
}
