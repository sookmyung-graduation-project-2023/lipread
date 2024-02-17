import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lipread/models/official_template_model.dart';
import 'package:lipread/models/unofficial_template_model.dart';
import 'package:lipread/screens/template_description/template_description_screen.dart';
import 'package:lipread/services/template_service.dart';
import 'package:lipread/utilities/app_color_scheme.dart';
import 'package:lipread/utilities/font_type.dart';

import 'customed_tab_bar.dart';

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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: CustomedTabBar(tabController: _tabController),
        ),
        const SizedBox(
          height: 24,
        ),
        SizedBox(
          height: 1000,
          child: TabBarView(
            controller: _tabController,
            children: [
              FutureBuilder(
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
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '공식',
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                TextButton(
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                    minimumSize: const Size(0, 0),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 16),
                                    foregroundColor: AppColor.grayScale.g700,
                                    backgroundColor: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: AppColor.grayScale.g700),
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    textStyle: TextStyle(
                                      fontFamily: FontType.pretendard.name,
                                      fontSize: 14,
                                      height: 1,
                                      fontVariations: const [
                                        FontVariation('wght', 500),
                                      ],
                                    ),
                                  ),
                                  child: const Row(
                                    children: [
                                      Text(
                                        '전체',
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Icon(Icons.arrow_drop_down_outlined),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: officialTemplates.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 12,
                                crossAxisSpacing: 12,
                                childAspectRatio: .7,
                              ),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          TemplateDescriptionScreen(
                                              officialTemplates[index].id),
                                    ),
                                  ),
                                  child: OfficialTemplateCard(
                                    id: officialTemplates[index].id,
                                    title: officialTemplates[index].title,
                                    emoji: officialTemplates[index].emoji,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    }
                  }),
              FutureBuilder(
                  future: _unofficialTemplates,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return const Text('Error');
                    } else {
                      final List<UnOfficialTemplateModel> unofficialTemplates =
                          snapshot.data!;
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '맞춤형',
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {},
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
                            ListView.separated(
                              shrinkWrap: true,
                              itemCount: unofficialTemplates.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          TemplateDescriptionScreen(
                                              unofficialTemplates[index].id),
                                    ),
                                  ),
                                  child: UnOfficialTemplateCard(
                                    id: unofficialTemplates[index].id,
                                    title: unofficialTemplates[index].title,
                                    emoji: unofficialTemplates[index].emoji,
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
            ],
          ),
        ),
      ],
    );
  }
}

class OfficialTemplateCard extends StatelessWidget {
  final String id;
  final String title;
  final String emoji;

  const OfficialTemplateCard({
    super.key,
    required this.id,
    required this.title,
    required this.emoji,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 20,
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
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            emoji,
            style: const TextStyle(
              fontSize: 52,
            ),
          ),
        ],
      ),
    );
  }
}

class UnOfficialTemplateCard extends StatelessWidget {
  final String id;
  final String title;
  final String emoji;
  final String? originalTemplateName;

  const UnOfficialTemplateCard({
    super.key,
    required this.id,
    required this.title,
    required this.emoji,
    this.originalTemplateName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 28,
        horizontal: 24,
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  originalTemplateName != null
                      ? '$originalTemplateName로부터 생성'
                      : '새로운 주제',
                  style: Theme.of(context).textTheme.labelMedium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyLarge,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Text(
            emoji,
            style: const TextStyle(
              fontSize: 28,
            ),
          ),
        ],
      ),
    );
  }
}
