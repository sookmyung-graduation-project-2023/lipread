import 'package:flutter/material.dart';
import 'package:lipread/services/template_service.dart';
import 'dart:developer' as developer;

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder(
          stream: TemplateService.createNewTemplate(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Text(snapshot.data ?? "노 데이터");
              case ConnectionState.none:
                return Text(snapshot.data ?? "노 데이터");
              case ConnectionState.active:
                return Text(snapshot.data ?? "노 데이터");
              case ConnectionState.done:
                if (snapshot.hasError) {
                  developer.log(snapshot.error.toString());
                  throw Error();
                }
                if (!snapshot.hasData) {
                  developer.log("no data");
                  return const Text("no data");
                } else {
                  return Text(snapshot.data ?? "노 데이터");
                }
            }
          },
        ),
      ),
    );
  }
}
