import 'package:flutter/material.dart';
import 'package:lipread/models/template/official_template_model.dart';
import 'package:lipread/models/template/unofficial_template_model.dart';
import 'package:lipread/screens/creat_template/screens/create_template_screen.dart';
import 'package:lipread/screens/creat_template/screens/template_title_input_screen.dart';
import 'package:lipread/screens/home/components/filter_button.dart';
import 'package:lipread/screens/template_description/template_description_screen.dart';
import 'package:lipread/services/template_service.dart';
import 'package:lipread/utilities/app_color_scheme.dart';
import 'package:lipread/utilities/variables.dart';
import 'package:lipread/components/empty_data.dart';

import 'customed_tab_bar.dart';
import 'official_template_card.dart';
import 'unofficial_template_card.dart';

class TabView extends StatefulWidget {
  const TabView({
    super.key,
  });

  @override
  State<TabView> createState() => _TabViewState();
}

class _TabViewState extends State<TabView> with SingleTickerProviderStateMixin {
  late Future<List<OfficialTemplateModel>> _officialTemplates;
  late Future<List<UnOfficialTemplateModel>> _unofficialTemplates;

  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: 0,
      animationDuration: const Duration(milliseconds: 800),
    );
    _officialTemplates = TemplateService.getOfficialTemplates();
    _unofficialTemplates = TemplateService.getUnOfficialTemplate();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _handleCategorySelected(OfficialCategoryType category) {
    setState(() {
      _officialTemplates =
          TemplateService.getOfficialTemplates(category: category);
      debugPrint(category.value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        const SizedBox(
          height: 24,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: CustomedTabBar(tabController: _tabController),
        ),
        const SizedBox(
          height: 24,
        ),
        Expanded(
          child: TabBarView(
            physics: const ClampingScrollPhysics(),
            controller: _tabController,
            children: [
              SingleChildScrollView(
                child: FutureBuilder(
                    future: _officialTemplates,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return const Text('Error');
                      } else {
                        final List<OfficialTemplateModel> officialTemplates =
                            snapshot.data!;
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '공식',
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                  FilterButton(
                                    handleCategorySelected:
                                        _handleCategorySelected,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              officialTemplates.isEmpty
                                  ? const Center(
                                      child: EmptyData(
                                          text: '올바른 결과를 찾을 수 없습니다 💦'))
                                  : GridView.builder(
                                      shrinkWrap: true,
                                      physics: const ClampingScrollPhysics(),
                                      itemCount: officialTemplates.length,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 12,
                                        crossAxisSpacing: 12,
                                        childAspectRatio: .8,
                                      ),
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  TemplateDescriptionScreen(
                                                      officialTemplates[index]
                                                          .id),
                                            ),
                                          ),
                                          child: OfficialTemplateCard(
                                            id: officialTemplates[index].id,
                                            title:
                                                officialTemplates[index].title,
                                            emoji:
                                                officialTemplates[index].emoji,
                                          ),
                                        );
                                      },
                                    ),
                            ],
                          ),
                        );
                      }
                    }),
              ),
              SingleChildScrollView(
                child: FutureBuilder(
                    future: _unofficialTemplates,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return const Text('Error');
                      } else {
                        final List<UnOfficialTemplateModel>
                            unofficialTemplates = snapshot.data!;
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '맞춤형',
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const CreateTemplateScreen())),
                                        icon: Icon(
                                          Icons.add_circle_outline,
                                          color: AppColor.grayScale.g700,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.delete_outline,
                                          color: AppColor.grayScale.g700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              unofficialTemplates.isEmpty
                                  ? const EmptyData(
                                      text: "+ 버튼을 눌러서\n맞춤형 대화를 생성해 볼까요?")
                                  : ListView.separated(
                                      shrinkWrap: true,
                                      itemCount: unofficialTemplates.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  TemplateDescriptionScreen(
                                                      unofficialTemplates[index]
                                                          .id),
                                            ),
                                          ),
                                          child: UnOfficialTemplateCard(
                                            id: unofficialTemplates[index].id,
                                            title: unofficialTemplates[index]
                                                .title,
                                            emoji: unofficialTemplates[index]
                                                .emoji,
                                            originalTemplateName:
                                                unofficialTemplates[index]
                                                    .originalTemplateName,
                                          ),
                                        );
                                      },
                                      separatorBuilder: (context, index) {
                                        return const SizedBox(
                                          height: 12,
                                        );
                                      },
                                    ),
                            ],
                          ),
                        );
                      }
                    }),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
