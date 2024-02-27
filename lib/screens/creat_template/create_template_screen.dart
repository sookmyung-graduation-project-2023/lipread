import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:lipread/components/role_avatar.dart';
import 'package:lipread/components/role_avatar_button.dart';
import 'package:lipread/utilities/app_color_scheme.dart';
import 'package:lipread/utilities/font_type.dart';
import 'package:lipread/utilities/variables.dart';

class CreateTemplateScreen extends StatefulWidget {
  const CreateTemplateScreen({super.key});

  @override
  State<CreateTemplateScreen> createState() => _CreateTemplateScreenState();
}

class _CreateTemplateScreenState extends State<CreateTemplateScreen> {
  CreatingTemplateStepType _templateStep =
      CreatingTemplateStepType.selectCreatingMethod;

  CreateTemplateType? selectedTemplateType;

  List<String> addWords = [];

  double indicatorValue = .1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('새로운 영상 만들기'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (_templateStep ==
                    CreatingTemplateStepType.selectCreatingMethod &&
                selectedTemplateType == CreateTemplateType.newSubject) {
              _templateStep = CreatingTemplateStepType.inputSubject;
              indicatorValue = .25;
            } else if (_templateStep ==
                    CreatingTemplateStepType.selectCreatingMethod &&
                selectedTemplateType == CreateTemplateType.recentSubject) {
              _templateStep = CreatingTemplateStepType.selectRecentSubject;
              indicatorValue = .5;
            } else if (_templateStep == CreatingTemplateStepType.inputSubject) {
              _templateStep = CreatingTemplateStepType.inputFirstRole;
              indicatorValue = .5;
            } else if (_templateStep ==
                CreatingTemplateStepType.inputFirstRole) {
              _templateStep = CreatingTemplateStepType.inputSecondRole;
              indicatorValue = .75;
            } else if (_templateStep ==
                    CreatingTemplateStepType.inputSecondRole ||
                _templateStep == CreatingTemplateStepType.selectRecentSubject) {
              _templateStep = CreatingTemplateStepType.addWord;
              indicatorValue = .9;
            } else if (_templateStep == CreatingTemplateStepType.addWord) {
              _templateStep = CreatingTemplateStepType.inputTitle;
              indicatorValue = .95;
            } else if (_templateStep == CreatingTemplateStepType.inputTitle) {
              debugPrint('완료');
            }
          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Column(
        children: [
          CreatingTemplateProgressIndicator(indicatorValue),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                if (_templateStep ==
                    CreatingTemplateStepType.selectCreatingMethod)
                  SelectTemplateTypeToCreate(
                    recentSubjectBtnOnPressed: () {
                      setState(() {
                        selectedTemplateType = CreateTemplateType.recentSubject;
                      });
                    },
                    newSubjectBtnOnPressed: () {
                      setState(() {
                        selectedTemplateType = CreateTemplateType.newSubject;
                      });
                    },
                    selectedTemplateType: selectedTemplateType,
                  ),
                if (_templateStep ==
                    CreatingTemplateStepType.selectRecentSubject)
                  const SelectRecentTemplate(),
                if (_templateStep == CreatingTemplateStepType.inputSubject)
                  const InputSubjectOfTemplate(),
                if (_templateStep == CreatingTemplateStepType.inputFirstRole)
                  const InputRoleOfTemplate(),
                if (_templateStep == CreatingTemplateStepType.inputSecondRole)
                  const InputRoleOfTemplate(),
                if (_templateStep == CreatingTemplateStepType.addWord)
                  AddWordOfTemplate(),
                if (_templateStep == CreatingTemplateStepType.inputTitle)
                  const InputTitleOfTemplate(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FloatingActionButton extends StatelessWidget {
  final void Function() onPressed;

  const FloatingActionButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
      return Padding(
        padding: EdgeInsets.only(
          left: 24,
          right: 24,
          bottom: isKeyboardVisible ? 8 : 44,
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

class CreatingTemplateProgressIndicator extends StatelessWidget {
  final double value;
  const CreatingTemplateProgressIndicator(
    this.value, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: value,
      color: AppColor.primaryColor,
      backgroundColor: AppColor.primaryLightColor,
      minHeight: 4,
    );
  }
}

class SelectTemplateTypeToCreate extends StatelessWidget {
  final CreateTemplateType? selectedTemplateType;

  final void Function() recentSubjectBtnOnPressed;
  final void Function() newSubjectBtnOnPressed;

  const SelectTemplateTypeToCreate({
    super.key,
    required this.selectedTemplateType,
    required this.recentSubjectBtnOnPressed,
    required this.newSubjectBtnOnPressed,
  });

  bool isSelected(CreateTemplateType type) {
    if (type == selectedTemplateType) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
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
            child: SquareButton(
              onPressed: recentSubjectBtnOnPressed,
              isSelected: isSelected(CreateTemplateType.recentSubject),
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
            child: SquareButton(
              onPressed: newSubjectBtnOnPressed,
              isSelected: isSelected(
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
      )
    ]);
  }
}

class SquareButton extends StatelessWidget {
  final void Function() onPressed;
  final Widget child;
  final bool isSelected;
  const SquareButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        minimumSize: const Size(0, 0),
        padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 16),
        foregroundColor:
            isSelected ? AppColor.primaryColor : AppColor.grayScale.g600,
        backgroundColor:
            isSelected ? AppColor.primaryLightColor : Colors.transparent,
        shape: RoundedRectangleBorder(
          side: BorderSide(
              color:
                  isSelected ? AppColor.primaryColor : AppColor.grayScale.g200),
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: TextStyle(
          fontFamily: FontType.pretendard.name,
          fontSize: 14,
          height: 1.55,
          fontVariations: [
            isSelected
                ? const FontVariation('wght', 600)
                : const FontVariation('wght', 500),
          ],
        ),
      ),
      child: child,
    );
  }
}

class SelectRecentTemplate extends StatelessWidget {
  const SelectRecentTemplate({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(
          height: 24,
        ),
        Text(
          "최근에 연습한 주제 중에서 새로운 영상을 만들고 싶은 주제를 선택해 주세요.",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(
          height: 12,
        ),
      ],
    );
  }
}

class InputSubjectOfTemplate extends StatelessWidget {
  const InputSubjectOfTemplate({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(
          height: 24,
        ),
        Text(
          "영상으로 만들고 싶은 주제를\n간략하게 설명해 주세요.",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(
          height: 12,
        ),
        TextField(
          maxLines: 3,
          maxLength: 100,
          style: Theme.of(context).textTheme.bodyMedium,
          decoration: const InputDecoration(
            hintText: 'ex. 카페에서 음료와 디저트를 주문한다. 카페 직원은 나에게 가장 맛있는 음료를 알려준다.',
          ),
        ),
      ],
    );
  }
}

class InputRoleOfTemplate extends StatelessWidget {
  const InputRoleOfTemplate({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(
          height: 24,
        ),
        Text(
          "영상에는 두 사람이 등장합니다. 첫 번째 사람과 어울리는 역할을 정해주세요.",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(
          height: 12,
        ),
        Text(
          "역할 이름",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(
          height: 12,
        ),
        TextField(
          maxLines: 1,
          maxLength: 20,
          style: Theme.of(context).textTheme.bodyMedium,
          decoration: const InputDecoration(
            hintText: 'ex. 카페 직원',
          ),
        ),
        const SizedBox(
          height: 32,
        ),
        Text(
          "역할 소개 및 설명",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(
          height: 12,
        ),
        TextField(
          maxLines: 3,
          maxLength: 100,
          style: Theme.of(context).textTheme.bodyMedium,
          decoration: const InputDecoration(
            hintText: 'ex. 카페에서 오래 일한 직원이다. 손님에게 맛있는 음식을 잘 추천해준다.',
          ),
        ),
        const SizedBox(
          height: 32,
        ),
        Text(
          "역할 이미지 선택하기",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(
          height: 12,
        ),
        const Row(
          children: [
            Expanded(
              child: RoleAvatarButton(
                label: '남성',
                isSelected: false,
                roleType: RoleType.man,
              ),
            ),
            SizedBox(
              width: 12,
            ),
            Expanded(
              child: RoleAvatarButton(
                label: '여성',
                isSelected: false,
                roleType: RoleType.woman,
              ),
            ),
            SizedBox(
              width: 12,
            ),
            Expanded(
              child: RoleAvatarButton(
                label: '중년 남성',
                isSelected: true,
                roleType: RoleType.oldMan,
              ),
            ),
            SizedBox(
              width: 12,
            ),
            Expanded(
              child: RoleAvatarButton(
                label: '중년 여성',
                isSelected: false,
                roleType: RoleType.oldWoman,
              ),
            ),
          ],
        )
      ],
    );
  }
}

class AddWordOfTemplate extends StatelessWidget {
  AddWordOfTemplate({
    super.key,
  });

  List<String> words = ['ajvls', 'awfes'];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(
          height: 24,
        ),
        Text(
          "영상으로 꼭 학습하고 싶은\n단어를 추가해 주세요.",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(
          height: 12,
        ),
        TextField(
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
          "추가한 단어나 문장",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(
          height: 12,
        ),
        Wrap(
          spacing: 8,
          runSpacing: 4,
          children: [
            for (var word in words)
              WordTag(
                word: word,
                onPressed: () {},
              ),
          ],
        ),
      ],
    );
  }
}

class WordTag extends StatelessWidget {
  final String word;
  final void Function() onPressed;
  const WordTag({
    super.key,
    required this.word,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        minimumSize: const Size(0, 0),
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 18,
        ),
        backgroundColor: Colors.transparent,
        foregroundColor: AppColor.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
          side: const BorderSide(
            width: 1,
            color: AppColor.primaryColor,
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
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(word),
          const SizedBox(
            width: 8,
          ),
          const Icon(
            Icons.cancel_outlined,
          )
        ],
      ),
    );
  }
}

class InputTitleOfTemplate extends StatelessWidget {
  const InputTitleOfTemplate({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(
          height: 24,
        ),
        Text(
          "마지막으로\n제목을 지어주세요.",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(
          height: 12,
        ),
        TextField(
          maxLines: 1,
          maxLength: 15,
          style: Theme.of(context).textTheme.bodyMedium,
          decoration: const InputDecoration(
            hintText: 'ex. 카페에서 음료 주문하기',
          ),
        ),
      ],
    );
  }
}
