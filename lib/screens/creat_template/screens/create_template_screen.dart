import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:lipread/providers/new_template_provider.dart';
import 'package:lipread/screens/creat_template/screens/new_template_topic_input_screen.dart';
import 'package:lipread/screens/creat_template/screens/template_title_input_screen.dart';
import 'package:lipread/utilities/app_color_scheme.dart';
import 'package:lipread/utilities/font_type.dart';
import 'package:lipread/utilities/variables.dart';
import 'package:provider/provider.dart';

import '../components/create_template_method_button.dart';
import '../components/create_template_progress_indicator.dart';
import 'select_recent_learned_topic_screen.dart';

class CreateTemplateScreen extends StatefulWidget {
  const CreateTemplateScreen({super.key});

  @override
  State<CreateTemplateScreen> createState() => _CreateTemplateScreenState();
}

class _CreateTemplateScreenState extends State<CreateTemplateScreen> {
  CreateTemplateType? _selectedTemplateType;

  bool _isBtnAvaliable = false;

  bool _isMethodSelected(CreateTemplateType type) {
    return _selectedTemplateType != null && type == _selectedTemplateType;
  }

  void _checkValidation() {
    setState(() {
      _isBtnAvaliable = _selectedTemplateType != null;
    });
  }

  void _routeToNextScreen() {
    context.read<NewTemplateProvider>().clearAll();
    if (_selectedTemplateType != null) {
      if (_selectedTemplateType == CreateTemplateType.newSubject) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const NewTemplateTopicInputScreen(),
            ));
      }
      if (_selectedTemplateType == CreateTemplateType.recentSubject) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SelectRecentLearnedTopicScreen(),
            ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('새로운 영상 만들기'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const CreateTemplateProgressIndicator(.1),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(
                      height: 24,
                    ),
                    Text(
                      "새로운 연습 영상을\n어떤 방법으로 만들고 싶나요?",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CreateTemplateMethodButton(
                            onPressed: () {
                              setState(() {
                                _selectedTemplateType =
                                    CreateTemplateType.recentSubject;
                                _checkValidation();
                              });
                            },
                            isSelected: _isMethodSelected(
                                CreateTemplateType.recentSubject),
                            child: Column(children: [
                              Image.asset('assets/images/img_history.png'),
                              const Text(
                                '최근 연습 주제로\n만들기',
                                textAlign: TextAlign.center,
                              ),
                            ]),
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          child: CreateTemplateMethodButton(
                            onPressed: () {
                              setState(() {
                                _selectedTemplateType =
                                    CreateTemplateType.newSubject;
                                _checkValidation();
                              });
                            },
                            isSelected: _isMethodSelected(
                              CreateTemplateType.newSubject,
                            ),
                            child: Column(children: [
                              Image.asset('assets/images/img_plus.png'),
                              const Text(
                                '새로운 주제로\n만들기',
                                textAlign: TextAlign.center,
                              ),
                            ]),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                TextButton(
                  onPressed: _isBtnAvaliable ? _routeToNextScreen : null,
                  child: const Text(
                    '다음 단계로',
                  ),
                ),
                const SizedBox(
                  height: 44,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FloatingActionButton extends StatelessWidget {
  final void Function()? onPressed;

  const FloatingActionButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
      return Padding(
        padding: const EdgeInsets.only(
          left: 24,
          right: 24,
          bottom: 44,
        ),
        child: TextButton(
          onPressed: onPressed,
          child: const Text(
            '다음 단계로',
          ),
        ),
      );
    });
  }
}
