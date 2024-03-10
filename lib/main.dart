import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:lipread/firebase_options.dart';
import 'package:lipread/providers/token_provider.dart';
import 'package:lipread/screens/creat_template/screens/learning_word_input_screen.dart';
import 'package:lipread/screens/creat_template/screens/new_template_topic_input_screen.dart';

import 'package:lipread/screens/login/login_screen.dart';
import 'package:lipread/utilities/app_color_scheme.dart';
import 'package:lipread/utilities/font_type.dart';
import 'package:provider/provider.dart';

import 'screens/creat_template/screens/create_template_screen.dart';
import 'screens/creat_template/screens/template_title_input_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();
  await initializeDefault();
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => TokenProvider())],
      child: const MyApp(),
    ),
  );
}

Future<void> initializeDefault() async {
  FirebaseApp app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  debugPrint('Initialized default app $app');
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
        bottomSheetTheme: bottomSheetTheme,
        inputDecorationTheme: inputDecorationTheme,
      ),
      home: const LoginScreen(),
    );
  }
}

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

extension SentenceCheckedStyles on TextTheme {
  TextStyle get wrongWord => TextStyle(
        fontSize: 16,
        fontFamily: FontType.pretendard.name,
        fontVariations: const [FontVariation('wght', 500)],
        color: AppColor.orangeColor,
        height: 1.55,
        decoration: TextDecoration.lineThrough,
        decorationColor: AppColor.orangeColor,
      );

  TextStyle get correctWord => TextStyle(
        fontSize: 16,
        fontFamily: FontType.pretendard.name,
        fontVariations: const [FontVariation('wght', 500)],
        color: AppColor.grayScale.g800,
        height: 1.55,
      );

  TextStyle get answerWord => TextStyle(
        fontSize: 16,
        fontFamily: FontType.pretendard.name,
        fontVariations: const [FontVariation('wght', 500)],
        color: AppColor.primaryColor,
        height: 1.55,
      );
}
