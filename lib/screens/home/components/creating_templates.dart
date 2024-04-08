import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lipread/models/template/creating_template_model.dart';

import 'package:lipread/screens/home/components/creating_unofficial_template_card.dart';
import 'package:lipread/services/api.dart';
import 'dart:developer' as developer;
import 'package:http/http.dart' as http;
import 'package:lipread/storage/secure_storage.dart';
import 'package:lipread/utilities/app_color_scheme.dart';

import 'package:web_socket_channel/web_socket_channel.dart';

class CreatingTemplates extends StatefulWidget {
  const CreatingTemplates({super.key});
  @override
  State<CreatingTemplates> createState() => _CreatingTemplatesState();
}

class _CreatingTemplatesState extends State<CreatingTemplates> {
  late String? userId;
  late String? deviceToken;
  WebSocketChannel? _channel;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeWebSocket();
    });
  }

  @override
  void dispose() {
    _channel!.sink.close();
    super.dispose();
  }

  void _initializeWebSocket() async {
    userId = await _getUserId();
    deviceToken = await _getDeviceToken();
    _channel = WebSocketChannel.connect(Uri.parse(
        '${API.websocktURL}/?userID=$userId&deviceToken=$deviceToken'));

    _channel!.sink.add(jsonEncode({'action': 'start', 'uid': userId}));

    setState(() {});
  }

  Future<String?> _getUserId() async {
    return await SecureStorage.storage.read(key: StorageKey.userId);
  }

  Future<String?> _getDeviceToken() async {
    return await SecureStorage.storage.read(key: StorageKey.deviceToken);
  }

  @override
  Widget build(BuildContext context) {
    return _channel == null
        ? const SizedBox.shrink()
        : StreamBuilder(
            stream: _channel!.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final data = jsonDecode(snapshot.data!)['data'];

                return Padding(
                  padding: EdgeInsets.only(bottom: data.length == 0 ? 0 : 12),
                  child: ListView.separated(
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
                      itemCount: data.length),
                );
              }
              return Text(
                '생성 중인 맞춤형 리스트 확인 중',
                style: TextStyle(
                  color: AppColor.grayScale.g500,
                ),
              );
            },
          );
  }
}
