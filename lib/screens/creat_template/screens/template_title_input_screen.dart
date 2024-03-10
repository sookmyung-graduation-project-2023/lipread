import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:lipread/components/role_avatar.dart';
import 'package:lipread/components/role_avatar_button.dart';
import 'package:lipread/screens/creat_template/screens/new_template_first_role_input_screen.dart';
import 'package:lipread/screens/home/home_screen.dart';
import 'package:lipread/utilities/app_color_scheme.dart';
import 'package:lipread/utilities/font_type.dart';
import 'package:lipread/utilities/variables.dart';

import '../components/create_template_progress_indicator.dart';

class TemplateTitleInputScreen extends StatefulWidget {
  const TemplateTitleInputScreen({
    super.key,
  });

  @override
  State<TemplateTitleInputScreen> createState() =>
      _TemplateTitleInputScreenState();
}

class _TemplateTitleInputScreenState extends State<TemplateTitleInputScreen> {
  final _titleTextController = TextEditingController();

  bool _isBtnAvaliable = false;

  @override
  void initState() {
    super.initState();
    _titleTextController.addListener(_checkValidation);
  }

  @override
  void dispose() {
    _titleTextController.dispose();
    super.dispose();
  }

  void _checkValidation() {
    setState(() {
      _isBtnAvaliable = _titleTextController.text.isNotEmpty;
    });
  }

  void _routeToNextScreen() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('영상 제목 정하기'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(
          bottom: 40,
          right: 24,
          left: 24,
        ),
        child: TextButton(
          onPressed: _isBtnAvaliable ? _routeToNextScreen : null,
          child: const Text('다음 단계로'),
        ),
      ),
      body: Column(
        children: [
          const CreateTemplateProgressIndicator(.2),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    height: 24,
                  ),
                  Text(
                    "마지막 단계에요!\n영상의 제목을 정해볼까요?",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  TextField(
                    controller: _titleTextController,
                    maxLines: 1,
                    maxLength: 15,
                    style: Theme.of(context).textTheme.bodyMedium,
                    decoration: const InputDecoration(
                      hintText: 'ex. 카페에서 음료 주문하기',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}