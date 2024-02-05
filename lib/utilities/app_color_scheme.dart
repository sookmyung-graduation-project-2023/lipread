import 'dart:ui';

import 'package:flutter/material.dart';

class AppColor {
  static const Color primaryColor = Color(0xff197AFF);
  static const Color primaryLightColor = Color(0xffF4F9FF);
  static final GrayScale grayScale = GrayScale();
}

class GrayScale {
  static final Map<int, Color> grayScaleColor = {
    100: const Color(0xFFFBFBFB),
    200: const Color(0xFFF0F4F8),
    300: const Color(0xFFD5DBE3),
    400: const Color(0xFFACB8C6),
    500: const Color(0xFF909DAC),
    600: const Color(0xFF73808F),
    700: const Color(0xFF4C5866),
    800: const Color(0xFF303642),
    900: const Color(0xFF181922),
  };

  Color get g100 => grayScaleColor[100]!;
  Color get g200 => grayScaleColor[200]!;
  Color get g300 => grayScaleColor[300]!;
  Color get g400 => grayScaleColor[400]!;
  Color get g500 => grayScaleColor[500]!;
  Color get g600 => grayScaleColor[600]!;
  Color get g700 => grayScaleColor[700]!;
  Color get g800 => grayScaleColor[800]!;
  Color get g900 => grayScaleColor[900]!;
}
