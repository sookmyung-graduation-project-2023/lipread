import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:lipread/models/message_model.dart';
import 'package:lipread/screens/learning/widgets/controls_overlay.dart';
import 'package:lipread/services/learning_service.dart';
import 'package:lipread/utilities/app_color_scheme.dart';
import 'package:video_player/video_player.dart';
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
  int currentLearningMessageIndex = 0;
  bool _speechEnabled = false;
  String _recognizedWords = '';

  late stt.SpeechToText _speechToText;
  late VideoPlayerController _controller;
  late Future<List<MessageModel>> _messages;

  String videoPath = "https://dyxryua47v6ay.cloudfront.net/a1.mp4";

  @override
  void initState() {
    super.initState();
    _messages = LearningService.getMessagesBy(widget.id);

    _speechToText = stt.SpeechToText();

    _initSpeech();

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

  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  void _startListening() async {
    debugPrint('Start Listening');
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  void _stopListening() async {
    debugPrint('Stop Listening');
    await _speechToText.stop();
    setState(() {});
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    debugPrint('음성 결과: ${result.finalResult}, 단어: ${result.recognizedWords}');
    setState(() {
      _recognizedWords = result.recognizedWords;
    });
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
                                    text: _recognizedWords,
                                    role: messages[index].text,
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
                      Positioned(
                        bottom: 44,
                        child: AvatarGlow(
                          glowColor: AppColor.primaryColor,
                          duration: const Duration(milliseconds: 1200),
                          glowRadiusFactor: 0.3,
                          animate: !_speechToText.isNotListening,
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColor.primaryColor,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: IconButton(
                                onPressed: _speechToText.isNotListening
                                    ? _startListening
                                    : _stopListening,
                                color: AppColor.primaryLightColor,
                                padding: const EdgeInsets.all(20),
                                iconSize: 40,
                                icon: Icon(
                                  _speechToText.isNotListening
                                      ? Icons.keyboard_voice_rounded
                                      : Icons.multitrack_audio_rounded,
                                )),
                          ),
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
