import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:lipread/firebase_options.dart';

import 'package:lipread/providers/new_template_provider.dart';
import 'package:lipread/providers/sharedpreferences_provider.dart';
import 'package:lipread/providers/token_provider.dart';
import 'package:lipread/routes/route_generator.dart';
import 'package:lipread/styles/theme_data.dart';
import 'package:lipread/utilities/app_color_scheme.dart';
import 'package:lipread/utilities/font_type.dart';

import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();
  await initializeDefault();
  SharedPreferencesProvider sharedPreferencesProvider =
      SharedPreferencesProvider();
  await sharedPreferencesProvider.init();
  TokenProvider tokenProvider = TokenProvider();
  await tokenProvider.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => NewTemplateProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => sharedPreferencesProvider,
        ),
        ChangeNotifierProvider(
          create: (_) => tokenProvider,
        )
      ],
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
      theme: appTheme,
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}

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
