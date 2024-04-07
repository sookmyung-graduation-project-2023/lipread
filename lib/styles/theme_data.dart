import 'package:flutter/material.dart';
import 'package:lipread/utilities/app_color_scheme.dart';
import 'package:lipread/utilities/font_type.dart';

import 'themes.dart';

var appTheme = ThemeData(
  useMaterial3: true,
  fontFamily: FontType.pretendard.name,
  colorScheme: const ColorScheme.light(
    primary: AppColor.primaryColor,
  ),
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: appBarTheme,
  textButtonTheme: textButtonTheme,
  textTheme: textTheme,
  bottomSheetTheme: bottomSheetTheme,
  inputDecorationTheme: inputDecorationTheme,
);
