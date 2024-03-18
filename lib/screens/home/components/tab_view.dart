import 'package:flutter/material.dart';
import 'package:lipread/exceptions/refresh_fail_exception.dart';
import 'package:lipread/models/arguments/template_description_screen_arguments.dart';
import 'package:lipread/models/template/official_template_model.dart';
import 'package:lipread/models/template/unofficial_template_model.dart';
import 'package:lipread/providers/sharedpreferences_provider.dart';
import 'package:lipread/providers/token_provider.dart';
import 'package:lipread/routes/routing_constants.dart';
import 'package:lipread/screens/creat_template/screens/create_template_screen.dart';
import 'package:lipread/screens/creat_template/screens/template_title_input_screen.dart';
import 'package:lipread/screens/home/components/creating_templates.dart';
import 'package:lipread/screens/home/components/filter_button.dart';
import 'package:lipread/screens/template_description/template_description_screen.dart';
import 'package:lipread/services/template_service.dart';
import 'package:lipread/utilities/app_color_scheme.dart';
import 'package:lipread/utilities/variables.dart';
import 'package:lipread/components/empty_data.dart';
import 'package:provider/provider.dart';

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
    _officialTemplates =
        TemplateService.getOfficialTemplates(context.read<TokenProvider>());
    _unofficialTemplates = TemplateService.getUnOfficialTemplate();
    _tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: 0,
      animationDuration: const Duration(milliseconds: 800),
    );
    _tabController.addListener(_handleTabChange);
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabChange);
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabChange() {
    if (_tabController.index == 1) {
      debugPrint('[test] ========');
      debugPrint('[test] tab 2');
      setState(() {
        _unofficialTemplates = TemplateService.getUnOfficialTemplate();
      });
    }
  }

  void _handleCategorySelected(OfficialCategoryType category) {
    setState(() {
      _officialTemplates = TemplateService.getOfficialTemplates(
          context.read<TokenProvider>(),
          category: category);
      debugPrint(category.value);
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('[test] build parent');
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
        Expanded(
          child: TabBarView(
            physics: const ClampingScrollPhysics(),
            controller: _tabController,
            children: [
              SingleChildScrollView(
                child: FutureBuilder(
                    future: _officialTemplates,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        if (snapshot.error is RefreshFailException) {
                          return const Text('error');
                        }
                      }
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        final List<OfficialTemplateModel> officialTemplates =
                            snapshot.data!;
                        return Padding(
                          padding: const EdgeInsets.only(
                              top: 16, bottom: 44, right: 24, left: 24),
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
                                          onTap: () => Navigator.pushNamed(
                                            context,
                                            RoutesName
                                                .templateDescriptionScreen,
                                            arguments:
                                                TemplateDescriptionScreenArguments(
                                                    officialTemplates[index]
                                                        .id),
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
              const UnOfficialTemplateTabItem(
                getTemplates: TemplateService.getUnOfficialTemplate,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class UnOfficialTemplateTabItem extends StatefulWidget {
  final Future<List<UnOfficialTemplateModel>> Function() getTemplates;

  const UnOfficialTemplateTabItem({super.key, required this.getTemplates});

  @override
  State<UnOfficialTemplateTabItem> createState() =>
      _UnOfficialTemplateTabItemState();
}

class _UnOfficialTemplateTabItemState extends State<UnOfficialTemplateTabItem> {
  @override
  Widget build(BuildContext context) {
    debugPrint('[test] build tab item');

    return SingleChildScrollView(
      child: FutureBuilder(
          future: widget.getTemplates(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              debugPrint('[test] <<<<loading!');
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Text('Error');
            } else {
              debugPrint('[test] build tab item with new List');
              final List<UnOfficialTemplateModel> unofficialTemplates =
                  snapshot.data!;
              return Padding(
                padding: const EdgeInsets.only(
                  top: 16,
                  right: 24,
                  left: 24,
                  bottom: 44,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '맞춤형',
                          style: Theme.of(context).textTheme.titleMedium,
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
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    const Column(
                      children: [
                        CreatingTemplates(),
                      ],
                    ),
                    unofficialTemplates.isEmpty
                        ? const EmptyData(text: "+ 버튼을 눌러서\n맞춤형 대화를 생성해 볼까요?")
                        : UnOfficialTemplatesListView(
                            unofficialTemplates: unofficialTemplates,
                          ),
                  ],
                ),
              );
            }
          }),
    );
  }
}

class UnOfficialTemplatesListView extends StatefulWidget {
  final List<UnOfficialTemplateModel> unofficialTemplates;
  const UnOfficialTemplatesListView(
      {super.key, required this.unofficialTemplates});

  @override
  State<UnOfficialTemplatesListView> createState() =>
      _UnOfficialTemplatesListViewState();
}

class _UnOfficialTemplatesListViewState
    extends State<UnOfficialTemplatesListView> {
  @override
  void initState() {
    debugPrint('[test] init list');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('[test] build list');
    return ListView.separated(
      shrinkWrap: true,
      itemCount: widget.unofficialTemplates.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => Navigator.pushNamed(
            context,
            RoutesName.templateDescriptionScreen,
            arguments: TemplateDescriptionScreenArguments(
                widget.unofficialTemplates[index].id),
          ),
          child: UnOfficialTemplateCard(
            id: widget.unofficialTemplates[index].id,
            title: widget.unofficialTemplates[index].title,
            emoji: widget.unofficialTemplates[index].emoji,
            originalTemplateName:
                widget.unofficialTemplates[index].originalTemplateName,
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(
          height: 12,
        );
      },
    );
  }
}
