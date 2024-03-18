import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:lipread/components/empty_data.dart';
import 'package:lipread/components/role_avatar_button.dart';
import 'package:lipread/models/history/recent_template_model.dart';
import 'package:lipread/providers/new_template_provider.dart';
import 'package:lipread/screens/creat_template/screens/learning_word_input_screen.dart';
import 'package:lipread/screens/creat_template/screens/new_template_second_role_input_screen.dart';
import 'package:lipread/screens/creat_template/screens/template_title_input_screen.dart';
import 'package:lipread/services/history_service.dart';
import 'package:lipread/utilities/app_color_scheme.dart';
import 'package:lipread/utilities/font_type.dart';
import 'package:lipread/utilities/variables.dart';
import 'package:provider/provider.dart';

import '../components/create_template_progress_indicator.dart';
import '../components/word_tag.dart';

class SelectRecentLearnedTopicScreen extends StatefulWidget {
  const SelectRecentLearnedTopicScreen({
    super.key,
  });

  @override
  State<SelectRecentLearnedTopicScreen> createState() =>
      _SelectRecentLearnedTopicScreenState();
}

class _SelectRecentLearnedTopicScreenState
    extends State<SelectRecentLearnedTopicScreen> {
  final Future<List<RecentTemplateModel>> _recentTemplates =
      HistoryService.getRecentLearningTemplates();

  bool _isBtnAvaliable = false;

  String? _parentTemplateId;

  void _handleOnpressedNextBtn() {
    context.read<NewTemplateProvider>().parentTemplateId = _parentTemplateId!;
    _routeToNextScreen();
  }

  void _routeToNextScreen() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const LearningWordInputScreen(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('최근에 학습한 대화 선택하기'),
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
                      "최근에 연습한 주제 중에서\n더 학습해보고 싶은 주제를 선택해 주세요",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    FutureBuilder(
                      future: _recentTemplates,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasData) {
                            final List<RecentTemplateModel> recentTemplates =
                                snapshot.data!;
                            return ListView.separated(
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return RecentTemplateCard(
                                  id: recentTemplates[index].id,
                                  emoji: recentTemplates[index].emoji,
                                  title: recentTemplates[index].title,
                                  isSelected:
                                      isSelected(recentTemplates, index),
                                  onPressed: () {
                                    setState(() {
                                      _parentTemplateId =
                                          recentTemplates[index].id;
                                      _isBtnAvaliable = true;
                                    });
                                  },
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const SizedBox(
                                  height: 16,
                                );
                              },
                              itemCount: recentTemplates.length,
                            );
                          }
                        }
                        return const Center(child: CircularProgressIndicator());
                      },
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

  bool isSelected(List<RecentTemplateModel> recentTemplates, int index) {
    debugPrint(_parentTemplateId);
    debugPrint((_parentTemplateId == recentTemplates[index].id ? true : false)
        .toString());
    return _parentTemplateId == recentTemplates[index].id ? true : false;
  }
}

class RecentTemplateCard extends StatelessWidget {
  final String id;
  final String emoji;
  final String title;
  final bool isSelected;
  final void Function() onPressed;

  const RecentTemplateCard({
    super.key,
    required this.id,
    required this.emoji,
    required this.title,
    required this.onPressed,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 24,
        ),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(12),
          ),
          color: isSelected ? AppColor.primaryLightColor : Colors.transparent,
          border: Border.all(
            width: 1,
            color: isSelected ? AppColor.primaryColor : AppColor.grayScale.g200,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontFamily: FontType.pretendard.name,
                fontVariations: isSelected
                    ? const [FontVariation('wght', 700)]
                    : const [FontVariation('wght', 500)],
                color: isSelected
                    ? AppColor.primaryColor
                    : AppColor.grayScale.g800,
                height: 1.55,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              emoji,
              style: const TextStyle(
                fontSize: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
