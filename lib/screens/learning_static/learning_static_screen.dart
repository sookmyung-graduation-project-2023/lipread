import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lipread/components/static_widget.dart';
import 'package:lipread/models/learning_static_model.dart';
import 'package:lipread/screens/learning_static/components/wrong_sentence.dart';
import 'package:lipread/services/learning_service.dart';

class LearningStaticScreen extends StatelessWidget {
  final String id;

  LearningStaticScreen(this.id, {super.key});

  late final Future<LearningStaticModel> _learningStatic =
      LearningService.getLearningStaticWith(id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('학습 통계'),
      ),
      body: FutureBuilder(
          future: _learningStatic,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                debugPrint('${snapshot.error}');
                return throw Error();
              } else {
                LearningStaticModel learningStatic = snapshot.data!;
                return SingleChildScrollView(
                  child: Padding(
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
                              child: Text(
                                learningStatic.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ),
                            Text(
                              learningStatic.emoji,
                              style: const TextStyle(fontSize: 32),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        Text(
                          "학습 통계",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: StaticWidget(
                                title: '정답률',
                                value: learningStatic.correctRate.toString(),
                              ),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Expanded(
                              child: StaticWidget(
                                title: '학습 시간',
                                value: learningStatic
                                    .totalLearningTimeInMilliseconds
                                    .toString(),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        Text(
                          "틀린 문장 모아보기",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        /*
                  틀린 문장이 없을 때도 해야함
                  learningStatic.wrongSetences
                  
                  const WrongSetenceCard(
                  wrongSetence: ,
                  ),
                  const WrongSetenceCard(
                    
                  ),*/
                      ],
                    ),
                  ),
                );
              }
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
