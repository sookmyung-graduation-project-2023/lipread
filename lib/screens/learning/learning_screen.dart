import 'package:flutter/material.dart';
import 'package:lipread/models/message_model.dart';
import 'package:lipread/screens/learning/widgets/controls_overlay.dart';
import 'package:lipread/services/learning_service.dart';
import 'package:lipread/utilities/app_color_scheme.dart';
import 'package:video_player/video_player.dart';
import 'package:record/record.dart';
import 'widgets/message_card.dart';

class LearningScreen extends StatefulWidget {
  final String id;

  const LearningScreen(
    this.id, {
    super.key,
  });

  @override
  State<LearningScreen> createState() => _LearningScreenState();
}

class _LearningScreenState extends State<LearningScreen> {
  bool isRecording = true;
  int currentLearningMessageIndex = 0;

  late AudioRecorder _recorder;
  late VideoPlayerController _controller;
  late Future<List<MessageModel>> _messages;

  String videoPath = "https://dyxryua47v6ay.cloudfront.net/a1.mp4";

  @override
  void initState() {
    super.initState();
    _messages = LearningService.getMessagesBy(widget.id);

    _recorder = AudioRecorder();

    _controller = VideoPlayerController.networkUrl(Uri.parse(videoPath));

    _controller.addListener(() {
      setState(() {});
    });

    _controller.initialize().then((_) => setState(() {}));
    _controller.play();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void _checkPermissionOfRecording() async {
    if (await _recorder.hasPermission()) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('학습하기'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.check_circle)),
        ],
      ),
      body: FutureBuilder(
        future: _messages,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              debugPrint('학습 데이터를 로드하던 중에 에러가 발생했습니다.');
              debugPrint('${snapshot.error}');
              return throw Error();
            } else {
              List<MessageModel> messages = snapshot.data!;
              return Column(
                children: [
                  AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: <Widget>[
                        VideoPlayer(_controller),
                        ControlsOverlay(controller: _controller),
                        VideoProgressIndicator(_controller,
                            allowScrubbing: true),
                      ],
                    ),
                  ),
                  Expanded(
                      child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Column(children: [
                            const SizedBox(
                              height: 32,
                            ),
                            ListView.separated(
                                shrinkWrap: true,
                                primary: false,
                                itemBuilder: (context, index) {
                                  return MessageCard(
                                    id: messages[index].id,
                                    role: messages[index].role,
                                    text: messages[index].text,
                                    videoUrl: messages[index].videoUrl,
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return const SizedBox(
                                    height: 20,
                                  );
                                },
                                itemCount: currentLearningMessageIndex + 1),
                            const SizedBox(
                              height: 48,
                            ),
                          ]),
                        ),
                      ),
                      if (isRecording)
                        Positioned(
                          bottom: 44,
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColor.primaryColor,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: IconButton(
                                onPressed: () {},
                                color: AppColor.primaryLightColor,
                                padding: const EdgeInsets.all(20),
                                iconSize: 40,
                                icon: const Icon(
                                  Icons.record_voice_over_rounded,
                                )),
                          ),
                        ),
                    ],
                  )),
                ],
              );
            }
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
