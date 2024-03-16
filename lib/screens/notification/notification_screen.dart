import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lipread/utilities/app_color_scheme.dart';
import 'package:lipread/utilities/font_type.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('알림'),
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    height: 24,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 28,
                      vertical: 24,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(12),
                      ),
                      border: Border.all(
                        width: 1,
                        color: AppColor.grayScale.g200,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "카페에서 음료 주문하기 맞춤형 대화가 생성되었습니다.",
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: FontType.pretendard.name,
                            fontVariations: const [FontVariation('wght', 600)],
                            color: AppColor.grayScale.g800,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          "14분 전",
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: FontType.pretendard.name,
                            fontVariations: const [FontVariation('wght', 500)],
                            color: AppColor.grayScale.g400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
