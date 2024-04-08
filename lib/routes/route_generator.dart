import 'package:flutter/material.dart';
import 'package:lipread/models/arguments/learning_screen.arguments.dart';
import 'package:lipread/models/arguments/learning_static_screen_arguments.dart';
import 'package:lipread/models/arguments/template_description_screen_arguments.dart';
import 'package:lipread/routes/routing_constants.dart';
import 'package:lipread/screens/home/home_screen.dart';
import 'package:lipread/screens/learning/learning_screen.dart';
import 'package:lipread/screens/learning_static/learning_static_screen.dart';
import 'package:lipread/screens/login/login_screen.dart';
import 'package:lipread/screens/template_description/template_description_screen.dart';
import 'package:lipread/storage/secure_storage.dart';

class RouteGenerator {
  static Future<bool> initialLoggin() async {
    final isLoggin =
        await SecureStorage.storage.read(key: StorageKey.isLoggedIn);
    return isLoggin == StorageValue.login;
  }

  static Route<dynamic> generateRoute(RouteSettings settings,
      {bool isLoggin = false}) {
    switch (settings.name) {
      case RoutesName.initialScreen:
        return buildRoute(
            FutureBuilder(
              future: initialLoggin(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else {
                  if (snapshot.hasError) {
                    return Scaffold(
                      body: Center(
                        child: Text('Error: ${snapshot.error}'),
                      ),
                    );
                  } else {
                    final bool isLoggin = snapshot.data ?? false;
                    return isLoggin ? const HomeScreen() : const LoginScreen();
                  }
                }
              },
            ),
            settings: settings);

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
    throw Error();
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
