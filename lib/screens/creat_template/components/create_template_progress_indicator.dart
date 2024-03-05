import 'package:flutter/material.dart';
import 'package:lipread/utilities/app_color_scheme.dart';

class CreateTemplateProgressIndicator extends StatelessWidget {
  final double value;
  const CreateTemplateProgressIndicator(
    this.value, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: value,
      color: AppColor.primaryColor,
      backgroundColor: AppColor.primaryLightColor,
      minHeight: 4,
    );
  }
}
