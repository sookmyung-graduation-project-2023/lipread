import 'package:flutter/material.dart';
import 'package:lipread/models/template/template_model.dart';
import 'package:lipread/screens/learning/learning_screen.dart';
import 'package:lipread/screens/learning/widgets/message_card.dart';
import 'package:lipread/services/template_service.dart';
import 'package:lipread/utilities/app_color_scheme.dart';
import 'package:lipread/utilities/variables.dart';
import 'package:lipread/widgets/empty_data.dart';

import 'widgets/learning_statics.dart';
import 'widgets/role_card.dart';

class TemplateDescriptionScreen extends StatefulWidget {
  final String id;

  const TemplateDescriptionScreen(this.id, {super.key});

  @override
  State<TemplateDescriptionScreen> createState() =>
      _TemplateDescriptionScreenState();
}

class _TemplateDescriptionScreenState extends State<TemplateDescriptionScreen> {
  late Future<TemplateModel> _templateDescription;

  @override
  void initState() {
    super.initState();
    _templateDescription = TemplateService.getTemplateDescriptionBy(widget.id);
  }

  void _routeToTrainingScreen(BuildContext context, String id) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LearningScreen(id)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('상세보기'),
      ),
      body: FutureBuilder(
          future: _templateDescription,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                debugPrint('상세보기 페이지를 로드하던 중에 에러가 발생했습니다.');
                debugPrint('${snapshot.error}');
                return throw Error();
              } else {
                final TemplateModel templateDescription = snapshot.data!;
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(
                              height: 24,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      templateDescription.officialCategory !=
                                              null
                                          ? Row(
                                              children: [
                                                const SmallTag('공식'),
                                                const SizedBox(
                                                  width: 4,
                                                ),
                                                SmallTag(templateDescription
                                                    .officialCategory!.value),
                                              ],
                                            )
                                          : Text(
                                              templateDescription
                                                          .originalTemplateName !=
                                                      null
                                                  ? '${templateDescription.originalTemplateName!}로부터 생성'
                                                  : '새로운 주제',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelMedium,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      Text(
                                        templateDescription.title,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge,
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  templateDescription.emoji,
                                  style: const TextStyle(fontSize: 52),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 32,
                            ),
                            Text(
                              '상황 설명',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 24,
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
                              child: Text(
                                templateDescription.explain,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                            const SizedBox(
                              height: 32,
                            ),
                            Text(
                              '역할 소개',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            RoleCard(
                              name: templateDescription.firstRole.name,
                              explain: templateDescription.firstRole.explain,
                              type: templateDescription.firstRole.type,
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            RoleCard(
                              name: templateDescription.secondRole.name,
                              explain: templateDescription.secondRole.explain,
                              type: templateDescription.secondRole.type,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 12,
                        color: AppColor.grayScale.g100,
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              '학습 통계',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            templateDescription.learningStatics != null
                                ? LearningStatics(
                                    totalLearningTimeInMilliseconds:
                                        templateDescription.learningStatics!
                                            .totalLearningTimeInMilliseconds,
                                    totalLearningCount: templateDescription
                                        .learningStatics!.totalLearningCount,
                                    correctAnswerRatio: templateDescription
                                        .learningStatics!.correctAnswerRatio,
                                    mostUncorrectedSentence: templateDescription
                                        .learningStatics!
                                        .mostUncorrectedSentence,
                                  )
                                : const EmptyData(
                                    text: '아직 학습한 기록이 없습니다.',
                                  ),
                            const SizedBox(
                              height: 32,
                            ),
                            TextButton(
                              onPressed: () {
                                _routeToTrainingScreen(context, widget.id);
                              },
                              child: const Text('학습 시작하기'),
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
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }
}
