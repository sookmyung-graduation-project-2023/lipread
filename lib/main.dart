import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lipread/screens/home/home_screen.dart';
import 'package:lipread/screens/login/login_screen.dart';
import 'package:lipread/utilities/app_color_scheme.dart';
import 'package:lipread/utilities/font_type.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LipRead',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: FontType.pretendard.name,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: appBarTheme,
        textButtonTheme: textButtonTheme,
        textTheme: textTheme,
      ),
      home: const LoginScreen(),
    );
  }
}

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
  displayMedium: const TextStyle(
    fontSize: 40,
    fontFamily: 'bronova',
    color: Colors.white,
    height: 1,
  ),
  headlineMedium: TextStyle(
    fontSize: 24,
    fontFamily: FontType.pretendard.name,
    fontVariations: const [FontVariation('wght', 600)],
    color: AppColor.primaryColor,
    height: 1.5,
  ),
  headlineSmall: TextStyle(
    fontSize: 24,
    fontFamily: FontType.pretendard.name,
    fontVariations: const [FontVariation('wght', 500)],
    color: Colors.white,
    height: 1.5,
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
