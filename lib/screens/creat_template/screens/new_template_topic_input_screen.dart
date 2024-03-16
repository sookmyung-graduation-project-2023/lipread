import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:lipread/components/role_avatar.dart';
import 'package:lipread/components/role_avatar_button.dart';
import 'package:lipread/providers/new_template_provider.dart';
import 'package:lipread/screens/creat_template/screens/new_template_first_role_input_screen.dart';
import 'package:lipread/utilities/app_color_scheme.dart';
import 'package:lipread/utilities/font_type.dart';
import 'package:lipread/utilities/variables.dart';
import 'package:provider/provider.dart';

import '../components/create_template_progress_indicator.dart';

class NewTemplateTopicInputScreen extends StatefulWidget {
  const NewTemplateTopicInputScreen({
    super.key,
  });

  @override
  State<NewTemplateTopicInputScreen> createState() =>
      _NewTemplateTopicInputScreenState();
}

class _NewTemplateTopicInputScreenState
    extends State<NewTemplateTopicInputScreen> {
  final _topicTextController = TextEditingController();

  bool _isBtnAvaliable = false;

  @override
  void initState() {
    super.initState();
    _topicTextController.addListener(_checkValidation);
  }

  @override
  void dispose() {
    _topicTextController.dispose();
    super.dispose();
  }

  void _checkValidation() {
    setState(() {
      _isBtnAvaliable = _topicTextController.text.isNotEmpty;
    });
  }

  void _handleOnpressedNextBtn() {
    context.read<NewTemplateProvider>().description = _topicTextController.text;
    _routeToNextScreen();
  }

  void _routeToNextScreen() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const NewTemplateFirstRoleInputScreen(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('영상 주제 정하기'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(
          bottom: 40,
          right: 24,
          left: 24,
        ),
        child: TextButton(
          onPressed: _isBtnAvaliable ? _handleOnpressedNextBtn : null,
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
                    "학습할 새로운 영상의\n주제는 무엇인가요?",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  TextField(
                    controller: _topicTextController,
                    maxLines: 3,
                    maxLength: 100,
                    style: Theme.of(context).textTheme.bodyMedium,
                    decoration: const InputDecoration(
                      hintText:
                          'ex. 카페에서 음료와 디저트를 주문한다. 카페 직원은 나에게 가장 맛있는 음료를 알려준다.',
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
