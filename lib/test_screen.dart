import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:lipread/models/template/creating_template_model.dart';
import 'package:lipread/screens/home/components/creating_unofficial_template_card.dart';
import 'package:lipread/services/template_service.dart';
import 'dart:developer' as developer;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});
  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  final url =
      'wss://xbg8dpf1x4.execute-api.ap-northeast-2.amazonaws.com/production';
  late WebSocketChannel _channel;
  late String uid = 'u114116366292754195999';
  late String deviceToken =
      'cHwQjYu-TEGLl7lqhtcTu6:APA91bFXmi4-X6y2cQG5hAA75lFLMxl46VaRwYZaED7aRdT3t9nYXKVE1CSxRGaT73l7wcQ2B9LFwKJBupG4YOm8aRkCGkQ6qO9btIbnE8ybPJnYzlRvnAenKc5H_8-VjGmNHcuOpKaM';

  @override
  void initState() {
    super.initState();

    _channel = WebSocketChannel.connect(
        Uri.parse('$url/?userID=$uid&deviceToken=$deviceToken'));

    _channel.sink.add(jsonEncode({'action': 'start', 'uid': uid}));
  }

  @override
  void dispose() {
    _channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              StreamBuilder(
                stream: _channel.stream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final data = jsonDecode(snapshot.data!)['data'];

                    return ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          CreatingTemplateModel item =
                              CreatingTemplateModel.fromJson(data[index]);
                          return CreatingUnOfficialTemplateCard(
                            id: item.id,
                            title: item.title,
                            percentage: item.percentage,
                            parentTitle: item.parentTitle ?? '',
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 10,
                          );
                        },
                        itemCount: data.length);
                  }
                  return const Text('준비중');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
