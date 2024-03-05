import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:lipread/components/empty_data.dart';
import 'package:lipread/components/role_avatar_button.dart';
import 'package:lipread/screens/creat_template/screens/new_template_second_role_input_screen.dart';
import 'package:lipread/screens/creat_template/screens/template_title_input_screen.dart';
import 'package:lipread/utilities/variables.dart';

import '../components/create_template_progress_indicator.dart';
import '../components/word_tag.dart';

class LearningWordInputScreen extends StatefulWidget {
  const LearningWordInputScreen({
    super.key,
  });

  @override
  State<LearningWordInputScreen> createState() =>
      _LearningWordInputScreenState();
}

class _LearningWordInputScreenState extends State<LearningWordInputScreen> {
  final _wordTextController = TextEditingController();

  List<String> words = [];

  void _routeToNextScreen() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const TemplateTitleInputScreen(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('단어 입력하기'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(
          bottom: 40,
          right: 24,
          left: 24,
        ),
        child: TextButton(
          onPressed: _routeToNextScreen,
          child: const Text('다음 단계로'),
        ),
      ),
      body: Column(
        children: [
          const CreateTemplateProgressIndicator(.2),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(
                      height: 24,
                    ),
                    Text(
                      "영상으로 꼭 학습하고 싶은\n단어를 추가해 보세요!",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      "단어 입력하기",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    TextField(
                      controller: _wordTextController,
                      onSubmitted: (value) {
                        setState(() {
                          if (value.isNotEmpty && !words.contains(value)) {
                            words.add(value);
                          }
                          _wordTextController.text = "";
                        });
                      },
                      maxLines: 1,
                      style: Theme.of(context).textTheme.bodyMedium,
                      decoration: const InputDecoration(
                        hintText: '학습하고 싶은 단어를 자유롭게 입력해 주세요. ',
                      ),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Text(
                      "입력한 단어",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    words.isEmpty
                        ? const Center(
                            child: EmptyData(
                                text: '아직 입력한 단어가 없어요.\n학습하고 싶은 단어를 입력해 주세요!'),
                          )
                        : Wrap(
                            spacing: 8,
                            runSpacing: 4,
                            children: [
                              for (var word in words)
                                WordTag(
                                  word: word,
                                  onPressed: () {
                                    setState(() {
                                      words.remove(word);
                                    });
                                  },
                                ),
                            ],
                          ),
                    const SizedBox(
                      height: 120,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
