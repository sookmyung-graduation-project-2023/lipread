import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:lipread/services/template_service.dart';
import 'dart:developer' as developer;
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/web_socket_channel.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});
  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  final url =
      'https://6ppmb67186.execute-api.ap-northeast-2.amazonaws.com/production';
  late WebSocketChannel _channel;

  @override
  void initState() {
    super.initState();
    _channel = WebSocketChannel.connect(Uri.parse(
        'wss://6ppmb67186.execute-api.ap-northeast-2.amazonaws.com/production/?userID=u1234'));
    _channel.sink.add('connect');
  }

  @override
  void dispose() {
    _channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            StreamBuilder(
              stream: _channel.stream,
              builder: (context, snapshot) {
                return Text(snapshot.hasData
                    ? '받아옴${snapshot.data}'
                    : '${snapshot.connectionState}');
              },
            ),
          ],
        ),
      ),
    );
  }
}
