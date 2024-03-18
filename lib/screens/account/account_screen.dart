import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lipread/utilities/app_color_scheme.dart';
import 'package:lipread/utilities/font_type.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final TextEditingController _controller = TextEditingController();
  bool _receiveNotification = true;
  bool _editingNameEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('계정'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 24,
              ),
              Text(
                "닉네임",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(
                height: 12,
              ),
              SizedBox(
                height: 52,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    !_editingNameEnabled
                        ? Expanded(
                            child: Text(
                              "윤재은",
                              style: TextStyle(
                                fontFamily: FontType.pretendard.name,
                                fontSize: 16,
                                fontVariations: const [
                                  FontVariation('wght', 600),
                                ],
                                color: AppColor.grayScale.g800,
                              ),
                            ),
                          )
                        : Flexible(
                            child: TextField(
                              onChanged: (value) => setState(() {}),
                              controller: _controller,
                              maxLines: 1,
                              keyboardType: TextInputType.multiline,
                              decoration: const InputDecoration(
                                hintText: '닉네임을 입력해 주세요',
                                filled: true,
                                fillColor: Colors.white,
                              ),
                            ),
                          ),
                    const SizedBox(
                      width: 8,
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          if (!_editingNameEnabled) {
                            _editingNameEnabled = true;
                          }
                        });
                      },
                      style: TextButton.styleFrom(
                        minimumSize: const Size(0, 0),
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 20,
                        ),
                        backgroundColor: AppColor.grayScale.g100,
                        foregroundColor: AppColor.grayScale.g600,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(
                            width: 1,
                            color: AppColor.grayScale.g200,
                          ),
                        ),
                        textStyle: TextStyle(
                          fontFamily: FontType.pretendard.name,
                          fontSize: 16,
                          height: 1,
                          fontVariations: const [
                            FontVariation('wght', 500),
                          ],
                        ),
                      ),
                      child: Text(
                        _editingNameEnabled ? '수정' : '변경',
                        style: TextStyle(
                          fontFamily: FontType.pretendard.name,
                          fontSize: 16,
                          fontVariations: const [
                            FontVariation('wght', 700),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              Text(
                "설정",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(
                height: 12,
              ),
              SettingItemWithExtraWidget(
                text: '알림 받기',
                widget: SizedBox(
                  width: 44,
                  child: CupertinoSwitch(
                      value: _receiveNotification,
                      activeColor: AppColor.primaryColor,
                      trackColor: AppColor.grayScale.g300,
                      onChanged: (value) {
                        setState(() {
                          _receiveNotification = value;
                        });
                      }),
                ),
              ),
              SettingItemWithExtraWidget(
                text: '앱 버전',
                widget: Text(
                  'v1.0',
                  style: TextStyle(
                    fontFamily: FontType.pretendard.name,
                    fontSize: 16,
                    fontVariations: const [
                      FontVariation('wght', 600),
                    ],
                    color: AppColor.grayScale.g800,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '로그아웃',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SettingItemWithExtraWidget extends StatelessWidget {
  final String text;
  final Widget widget;

  const SettingItemWithExtraWidget({
    required this.text,
    required this.widget,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          widget
        ],
      ),
    );
  }
}
