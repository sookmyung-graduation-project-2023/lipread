import 'dart:async';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';

import 'package:lipread/utilities/variables.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:lipread/models/message/message_model.dart';
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
  int _seconds = 0;
  int _currentLearningMessageIndex = 0;
  bool _speechEnabled = false;
  String _recognizedWords = '';

  LearningStateType _learningStateType = LearningStateType.beforeRecorded;

  late Timer _timer;
  late stt.SpeechToText _speechToText;
  late VideoPlayerController _controller;
  VideoPlayerController videoPlayerController =
      VideoPlayerController.networkUrl(Uri.parse(''));

  late ValueNotifier<String> videoFuture;

  late String videoPath;
  late Future<List<MessageModel>> _messages;

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
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  Future<void> play(String url) async {
    if (url.isEmpty) return;
    if (videoPlayerController.value.isInitialized) {
      await videoPlayerController.dispose();
    }
    videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(url));

    return videoPlayerController.initialize().then((value) {
      videoPlayerController.play();
    });
  }

  void _startListening() async {
    debugPrint('Start Listening');
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  void _stopListening() async {
    debugPrint('Stop Listening');
    await _speechToText.stop();
    _learningStateType = LearningStateType.recorded;
    setState(() {});
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    debugPrint('음성 결과: ${result.finalResult}, 단어: ${result.recognizedWords}');
    setState(() {
      _recognizedWords = result.recognizedWords;
      if (result.finalResult) _learningStateType = LearningStateType.recorded;
    });
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _seconds++;
      debugPrint(_seconds.toString());
    });
  }

  void _stopTimer() {
    _timer.cancel();
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
                  /*
                  ValueListenableBuilder(
                      valueListenable: videoFuture,
                      builder: (context, value, child) {
                        return AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child: value == null
                              ? const Text('no value')
                              : FutureBuilder(
                                  future: value,
                                  builder: (context, snapshot) {
                                    return Stack(
                                      alignment: Alignment.bottomCenter,
                                      children: <Widget>[
                                        VideoPlayer(_controller),
                                        ControlsOverlay(
                                            controller: _controller),
                                        VideoProgressIndicator(
                                          _controller,
                                          allowScrubbing: true,
                                        ),
                                      ],
                                    );
                                  }),
                        );
                      }),*/
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
                                  if (index < _currentLearningMessageIndex) {
                                    return MessageCard(
                                      id: index,
                                      text: messages[index].text,
                                      role: messages[index].role,
                                      videoUrl: messages[index].videoUrl,
                                      messageCheck:
                                          messages[index].messageCheck,
                                      learningStateType:
                                          LearningStateType.completed,
                                    );
                                  }
                                  return MessageCard(
                                    id: index,
                                    text: _recognizedWords,
                                    role: messages[index].role,
                                    videoUrl: messages[index].videoUrl,
                                    learningStateType: _learningStateType,
                                    messageCheck: messages[index].messageCheck,
                                    onPressedRerecord: () {
                                      setState(() {
                                        _recognizedWords = '';
                                        _learningStateType =
                                            LearningStateType.beforeRecorded;
                                      });
                                    },
                                    onPressedCheck: () async {
                                      messages[index].messageCheck =
                                          await LearningService
                                              .checkMessageWith(
                                                  _recognizedWords,
                                                  messages[index].text);

                                      setState(() {
                                        _learningStateType =
                                            LearningStateType.corrected;
                                      });
                                    },
                                    onPressedComplete: () {
                                      setState(() {
                                        _learningStateType =
                                            LearningStateType.beforeRecorded;
                                        _recognizedWords = '';
                                        _currentLearningMessageIndex++;
                                      });
                                    },
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return const SizedBox(
                                    height: 20,
                                  );
                                },
                                itemCount: _currentLearningMessageIndex + 1),
                            const SizedBox(
                              height: 160,
                            ),
                          ]),
                        ),
                      ),
                      if (_learningStateType ==
                          LearningStateType.beforeRecorded)
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
