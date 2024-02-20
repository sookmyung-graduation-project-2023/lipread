import 'package:flutter/material.dart';
import 'package:lipread/utilities/app_color_scheme.dart';
import 'package:lipread/utilities/font_type.dart';

class PercentangeCircularIndicator extends StatelessWidget {
  final double value;

  const PercentangeCircularIndicator(
    this.value, {
    super.key,
  });

  int _convertRatioToPercentage(double value) {
    return (value * 100).round();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 84,
          height: 84,
          child: CircularProgressIndicator(
            value: value,
            color: AppColor.primaryColor,
            backgroundColor: AppColor.primaryLightColor,
            strokeWidth: 36,
          ),
        ),
        const SizedBox(
          height: 32,
        ),
        Text(
          '${_convertRatioToPercentage(value)}%',
          style: TextStyle(
            fontSize: 16,
            fontFamily: FontType.pretendard.name,
            fontVariations: const [FontVariation('wght', 700)],
            color: AppColor.primaryColor,
            height: 1,
          ),
        ),
      ],
    );
  }
}
