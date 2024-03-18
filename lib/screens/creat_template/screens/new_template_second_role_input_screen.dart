import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:lipread/components/role_avatar.dart';
import 'package:lipread/components/role_avatar_button.dart';
import 'package:lipread/models/role_model.dart';
import 'package:lipread/providers/new_template_provider.dart';
import 'package:lipread/screens/creat_template/screens/learning_word_input_screen.dart';
import 'package:lipread/utilities/app_color_scheme.dart';
import 'package:lipread/utilities/font_type.dart';
import 'package:lipread/utilities/variables.dart';
import 'package:provider/provider.dart';

import '../components/create_template_progress_indicator.dart';

class NewTemplateSecondRoleInputScreen extends StatefulWidget {
  const NewTemplateSecondRoleInputScreen({
    super.key,
  });

  @override
  State<NewTemplateSecondRoleInputScreen> createState() =>
      _NewTemplateSecondRoleInputScreenState();
}

class _NewTemplateSecondRoleInputScreenState
    extends State<NewTemplateSecondRoleInputScreen> {
  final _roleNameTextController = TextEditingController();
  final _roleExplainationTextController = TextEditingController();

  RoleType? _selectedRoleType;
  bool _isBtnAvaliable = false;

  @override
  void initState() {
    super.initState();
    _roleNameTextController.addListener(_checkValidation);
    _roleExplainationTextController.addListener(_checkValidation);
  }

  @override
  void dispose() {
    _roleNameTextController.dispose();
    _roleExplainationTextController.dispose();
    super.dispose();
  }

  void _checkValidation() {
    setState(() {
      _isBtnAvaliable = _roleNameTextController.text.isNotEmpty &&
          _roleExplainationTextController.text.isNotEmpty &&
          _selectedRoleType != null;
    });
  }

  bool _isRoleSelected(RoleType role) {
    return _selectedRoleType != null && role == _selectedRoleType;
  }

  void _handleOnpressedNextBtn() {
    final RoleModel role = RoleModel(
        type: _selectedRoleType!,
        name: _roleNameTextController.text,
        explain: _roleExplainationTextController.text);
    context.read<NewTemplateProvider>().secondRole = role;
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
        title: const Text('두 번째 역할 정하기'),
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
          const CreateTemplateProgressIndicator(.6),
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
                      "두 번째 사람의\n역할을 정해주세요.",
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
                      controller: _roleNameTextController,
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
                      controller: _roleExplainationTextController,
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
                    Row(
                      children: [
                        Expanded(
                          child: RoleAvatarButton(
                            onPressed: () {
                              setState(() {
                                _selectedRoleType = RoleType.man;
                                _checkValidation();
                              });
                            },
                            isSelected: _isRoleSelected(RoleType.man),
                            roleType: RoleType.man,
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          child: RoleAvatarButton(
                            onPressed: () {
                              setState(() {
                                _selectedRoleType = RoleType.woman;
                                _checkValidation();
                              });
                            },
                            isSelected: _isRoleSelected(RoleType.woman),
                            roleType: RoleType.woman,
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          child: RoleAvatarButton(
                            onPressed: () {
                              setState(() {
                                _selectedRoleType = RoleType.oldMan;
                                _checkValidation();
                              });
                            },
                            isSelected: _isRoleSelected(RoleType.oldMan),
                            roleType: RoleType.oldMan,
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          child: RoleAvatarButton(
                            onPressed: () {
                              setState(() {
                                _selectedRoleType = RoleType.oldWoman;
                                _checkValidation();
                              });
                            },
                            isSelected: _isRoleSelected(RoleType.oldWoman),
                            roleType: RoleType.oldWoman,
                          ),
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
