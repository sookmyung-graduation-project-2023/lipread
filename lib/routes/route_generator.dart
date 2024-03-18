import 'package:flutter/material.dart';
import 'package:lipread/models/arguments/learning_screen.arguments.dart';
import 'package:lipread/models/arguments/learning_static_screen_arguments.dart';
import 'package:lipread/models/arguments/template_description_screen_arguments.dart';
import 'package:lipread/providers/sharedpreferences_provider.dart';
import 'package:lipread/routes/routing_constants.dart';
import 'package:lipread/screens/home/home_screen.dart';
import 'package:lipread/screens/learning/learning_screen.dart';
import 'package:lipread/screens/learning_static/learning_static_screen.dart';
import 'package:lipread/screens/login/login_screen.dart';
import 'package:lipread/screens/template_description/template_description_screen.dart';
import 'package:provider/provider.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.initialScreen:
        return buildRoute(Consumer<SharedPreferencesProvider>(
          builder: (context,
              SharedPreferencesProvider sharedPreferencesProvider, _) {
            return sharedPreferencesProvider.isLoggedIn
                ? const HomeScreen()
                : const LoginScreen();
          },
        ), settings: settings);
      case RoutesName.templateDescriptionScreen:
        final arguments =
            settings.arguments as TemplateDescriptionScreenArguments;
        return buildRoute(TemplateDescriptionScreen(arguments),
            settings: settings);
      case RoutesName.learningScreen:
        final arguments = settings.arguments as LearningScreenArguments;
        return buildRoute(LearningScreen(arguments), settings: settings);
      case RoutesName.learningStaticScreen:
        final arguments = settings.arguments as LearningStaticScreenArguments;
        return buildRoute(LearningStaticScreen(arguments), settings: settings);
      default:
        return _errorRoute();
    }
  }

  static MaterialPageRoute buildRoute(Widget child,
      {required RouteSettings settings}) {
    return MaterialPageRoute(
        settings: settings, builder: (BuildContext context) => child);
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'ERROR!!',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: const Center(
          child: Text('에러'),
        ),
      );
    });
  }
}
