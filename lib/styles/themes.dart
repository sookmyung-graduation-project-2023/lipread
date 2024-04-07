import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lipread/utilities/app_color_scheme.dart';
import 'package:lipread/utilities/font_type.dart';

const bottomSheetTheme = BottomSheetThemeData(
  backgroundColor: Colors.white,
  surfaceTintColor: Colors.transparent,
);

var inputDecorationTheme = InputDecorationTheme(
  contentPadding: const EdgeInsets.symmetric(
    vertical: 20,
    horizontal: 24,
  ),
  hintStyle: TextStyle(
    fontSize: 16,
    fontFamily: FontType.pretendard.name,
    fontVariations: const [FontVariation('wght', 400)],
    color: AppColor.grayScale.g300,
    height: 1.55,
  ),
  counterStyle: TextStyle(
    fontSize: 14,
    fontFamily: FontType.pretendard.name,
    fontVariations: const [FontVariation('wght', 500)],
    color: AppColor.grayScale.g500,
  ),
  errorStyle: TextStyle(
    fontSize: 14,
    fontFamily: FontType.pretendard.name,
    fontVariations: const [FontVariation('wght', 600)],
    color: AppColor.orangeColor,
    height: 1.55,
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(
      color: AppColor.grayScale.g300,
      width: 1.0,
    ),
  ),
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: const BorderSide(
      color: AppColor.orangeColor,
      width: 1.0,
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(
      color: AppColor.grayScale.g300,
      width: 1.5,
    ),
  ),
);

var appBarTheme = AppBarTheme(
  color: Colors.transparent,
  scrolledUnderElevation: 0.0,
  titleSpacing: 24,
  titleTextStyle: TextStyle(
    color: AppColor.grayScale.g900,
    fontSize: 18,
    fontFamily: FontType.pretendard.name,
    fontVariations: const [FontVariation('wght', 700)],
  ),
  iconTheme: IconThemeData(
    color: AppColor.grayScale.g900,
    size: 24,
  ),
  actionsIconTheme: IconThemeData(
    color: AppColor.grayScale.g900,
    size: 24,
  ),
);

var textButtonTheme = TextButtonThemeData(
  style: TextButton.styleFrom(
    minimumSize: const Size(382, 52),
    padding: const EdgeInsets.symmetric(vertical: 16),
    backgroundColor: AppColor.primaryColor,
    foregroundColor: Colors.white,
    disabledBackgroundColor: AppColor.grayScale.g200,
    disabledForegroundColor: AppColor.grayScale.g400,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    textStyle: TextStyle(
      fontFamily: FontType.pretendard.name,
      fontSize: 16,
      height: 1,
      fontVariations: const [
        FontVariation('wght', 700),
      ],
    ),
  ),
);

var textTheme = TextTheme(
  displayMedium: TextStyle(
    fontSize: 36,
    fontFamily: FontType.bronova.name,
    color: Colors.white,
    height: 1,
  ),
  headlineMedium: TextStyle(
    fontSize: 24,
    fontFamily: FontType.pretendard.name,
    fontVariations: const [FontVariation('wght', 600)],
    color: AppColor.primaryColor,
    height: 1.4,
  ),
  headlineSmall: TextStyle(
    fontSize: 24,
    fontFamily: FontType.pretendard.name,
    fontVariations: const [FontVariation('wght', 500)],
    color: Colors.white,
    height: 1.4,
  ),
  titleLarge: TextStyle(
    fontSize: 20,
    fontFamily: FontType.pretendard.name,
    fontVariations: const [FontVariation('wght', 600)],
    color: AppColor.grayScale.g900,
    height: 1,
  ),
  titleMedium: TextStyle(
    fontSize: 18,
    fontFamily: FontType.pretendard.name,
    fontVariations: const [FontVariation('wght', 600)],
    color: AppColor.grayScale.g900,
    height: 1,
  ),
  titleSmall: TextStyle(
    fontSize: 16,
    fontFamily: FontType.pretendard.name,
    fontVariations: const [FontVariation('wght', 600)],
    color: AppColor.grayScale.g900,
    height: 1,
  ),
  bodyLarge: TextStyle(
    fontSize: 18,
    fontFamily: FontType.pretendard.name,
    fontVariations: const [FontVariation('wght', 600)],
    color: AppColor.grayScale.g800,
    height: 1.55,
  ),
  bodyMedium: TextStyle(
    fontSize: 16,
    fontFamily: FontType.pretendard.name,
    fontVariations: const [FontVariation('wght', 500)],
    color: AppColor.grayScale.g800,
    height: 1.55,
  ),
  labelMedium: TextStyle(
    fontSize: 14,
    fontFamily: FontType.pretendard.name,
    fontVariations: const [FontVariation('wght', 600)],
    color: AppColor.grayScale.g500,
    height: 1,
  ),
);
