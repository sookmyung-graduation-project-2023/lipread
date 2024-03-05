import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lipread/services/template_service.dart';
import 'dart:developer' as developer;
import 'package:http/http.dart' as http;

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});
  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  String text = 'test';
  @override
  void initState() {
    super.initState();
    subscribe();
  }

  subscribe() async {
    developer.log("Subscribing..");
    try {
      TemplateService.createNewTemplate().asStream().listen((streamedResponse) {
        developer.log(
            "Received streamedResponse.statusCode:${streamedResponse.statusCode}");
        streamedResponse.stream.listen((data) {
          setState(() {
            text = utf8.decode(data);
          });
          developer.log("Received data:${utf8.decode(data)}");
        });
      });
    } catch (e) {
      developer.log("Caught $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(text),
      ),
    );
  }
}
