import 'dart:async';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lipread/components/modal_bottom_sheet.dart';
import 'package:lipread/models/arguments/learning_screen.arguments.dart';
import 'package:lipread/models/arguments/learning_static_screen_arguments.dart';
import 'package:lipread/models/learning_static_model.dart';
import 'package:lipread/routes/routing_constants.dart';
import 'package:lipread/screens/learning_static/learning_static_screen.dart';
import 'package:lipread/screens/template_description/template_description_screen.dart';
import 'package:lipread/utilities/font_type.dart';

import 'package:lipread/utilities/variables.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:lipread/models/message/message_model.dart';
import 'package:lipread/screens/learning/components/controls_overlay.dart';
import 'package:lipread/services/learning_service.dart';
import 'package:lipread/utilities/app_color_scheme.dart';
import 'package:video_player/video_player.dart';
import 'components/message_card.dart';

class LearningScreen extends StatefulWidget {
  final LearningScreenArguments arguments;

  const LearningScreen(
    this.arguments, {
    super.key,
  });

  @override
  State<LearningScreen> createState() => _LearningScreenState();
}

class _LearningScreenState extends State<LearningScreen> {
  bool isLoading = true;
  int _seconds = 0;
  int _currentLearningMessageIndex = 0;
  int _learnedSentenceCount = 0;
  final List<MessageModel> _wrongSentences = [];
  String _recognizedWords = "";

  LearningStateType _learningStateType = LearningStateType.beforeRecorded;

  late Timer _timer;
  late stt.SpeechToText _speechToText;
  late VideoPlayerController _controller;
  String videoPath = "";

  late List<MessageModel> _messages;
  final ScrollController _scrollController = ScrollController();

  void fetchData() async {
    _messages = await LearningService.getMessagesBy(widget.arguments.id);
    videoPath = _messages[0].videoUrl;
    _controller = VideoPlayerController.networkUrl(Uri.parse(videoPath));

    _controller.addListener(() {
      setState(() {});
    });

    _controller.initialize().then((_) => setState(() {}));
    _startTimer();
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchData();
    _speechToText = stt.SpeechToText();
    _initSpeech();
  }

  @override
  void dispose() {
    _controller.removeListener(() {
      setState(() {});
    });
    _controller.dispose();
    _stopTimer();
    super.dispose();
  }

  void _initSpeech() async {
    await _speechToText.initialize();
    setState(() {});
  }

  void _scrollDown() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(seconds: 2),
      curve: Curves.fastOutSlowIn,
    );
  }

  Future<void> play(String url) async {
    if (url.isEmpty) return;
    if (_controller.value.isInitialized) {
      await _controller.dispose();
    }
    _controller = VideoPlayerController.networkUrl(Uri.parse(videoPath));

    return _controller.initialize().then((value) {
      _controller.play();
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
    if (_recognizedWords == '') {
      _learningStateType = LearningStateType.beforeRecorded;
      Fluttertoast.showToast(
        msg: "음성을 제대로 녹음해 주세요",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 16,
      );
    } else {
      _learningStateType = LearningStateType.recorded;
    }
    setState(() {});
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    debugPrint('음성 결과: ${result.finalResult}, 단어: ${result.recognizedWords}');
    setState(() {
      _recognizedWords = result.recognizedWords;
      debugPrint('word: $_recognizedWords');
      if (result.finalResult) {
        if (_recognizedWords == '') {
          _learningStateType = LearningStateType.beforeRecorded;
        } else {
          _learningStateType = LearningStateType.recorded;
        }
      }
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
    debugPrint('stop timer');
    debugPrint(_seconds.toString());
  }

  Future<String> _saveStudy() async {
    LearningStaticModel result = LearningStaticModel(
      learningSentenceCount: _learnedSentenceCount,
      emoji: widget.arguments.emoji,
      title: widget.arguments.title,
      totalLearningTimeInMilliseconds: _seconds * 1000,
      correctRate: 1 - (_wrongSentences.length / _learnedSentenceCount),
      wrongSetences: [..._wrongSentences.map((e) => e.getWrongSetence())],
    );

    return await LearningService.saveLearningStatic(
        widget.arguments.id, result);
  }

  void _finishStudy() async {
    debugPrint('finished');
    final id = await _saveStudy();

    Navigator.pushNamedAndRemoveUntil(
      context,
      RoutesName.learningStaticScreen,
      (route) => route.settings.name == RoutesName.initialScreen,
      arguments: LearningStaticScreenArguments(id),
    );
  }

  void _showModalBottomSheet() {
    showModalBottomSheet(
      context: context,
      elevation: 12,
      isDismissible: true,
      barrierColor: AppColor.grayScale.g900.withOpacity(.4),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(32),
        ),
      ),
      isScrollControlled: true,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * .52,
      ),
      builder: (context) {
        return ModalBottomSheet(
            emoji: '😲',
            title: '학습을 종료하시겠어요?',
            description: '다음에 이어서 학습할 수 없어요.\n지금까지 학습한 기록만 저장돼요.',
            actionButtonText: '네 종료할게요',
            backButtonText: '계속 학습하기',
            actionButtonOnPressed: _finishStudy,
            backButtonOnPressed: () => Navigator.pop(context));
      },
    );
  }

  void _showBack() {
    showModalBottomSheet(
      context: context,
      routeSettings: const RouteSettings(),
      elevation: 12,
      isDismissible: true,
      barrierColor: AppColor.grayScale.g900.withOpacity(.4),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(32),
        ),
      ),
      isScrollControlled: true,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * .52,
      ),
      builder: (context) {
        return ModalBottomSheet(
          emoji: '😨',
          title: '학습을 그만두시겠어요?',
          description: '지금 학습을 종료하면\n학습한 기록이 저장되지 않아요.',
          actionButtonText: '네 그만할래요',
          actionButtonColor: AppColor.orangeColor,
          backButtonText: '계속 학습하기',
          actionButtonOnPressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
          backButtonOnPressed: () => Navigator.pop(context),
        );
      },
    );
  }

  void _setVideo(String url) {
    try {
      _controller.dispose();
    } catch (e) {}
    _controller = VideoPlayerController.networkUrl(Uri.parse(url));

    _controller.addListener(() {
      setState(() {});
    });

    _controller.initialize().then((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Scaffold(
            body: Center(
            child: CircularProgressIndicator(),
          ))
        : PopScope(
            canPop: false,
            onPopInvoked: (bool didPop) {
              if (didPop) {
                return;
              }
              _showBack();
            },
            child: Scaffold(
              appBar: AppBar(
                title: const Text('학습하기'),
                automaticallyImplyLeading: false,
                actions: [
                  TextButton(
                      onPressed: _learnedSentenceCount != 0 && _seconds != 00
                          ? _showModalBottomSheet
                          : null,
                      style: TextButton.styleFrom(
                        minimumSize: const Size(0, 0),
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 20,
                        ),
                        backgroundColor: Colors.transparent,
                        foregroundColor: AppColor.primaryColor,
                        textStyle: TextStyle(
                          fontFamily: FontType.pretendard.name,
                          fontSize: 16,
                          height: 1,
                          fontVariations: const [
                            FontVariation('wght', 700),
                          ],
                        ),
                      ),
                      child: const Text('학습 종료')),
                ],
              ),
              body: Column(
                children: [
                  AspectRatio(
                    aspectRatio: 5 / 3,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: <Widget>[
                        VideoPlayer(_controller),
                        ControlsOverlay(controller: _controller),
                        VideoProgressIndicator(
                          _controller,
                          allowScrubbing: true,
                          colors: VideoProgressColors(
                            playedColor: AppColor.primaryColor,
                            bufferedColor: AppColor.grayScale.g300,
                            backgroundColor: AppColor.grayScale.g300,
                          ),
                        ),
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
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const SizedBox(
                                  height: 32,
                                ),
                                ListView.separated(
                                    controller: _scrollController,
                                    shrinkWrap: true,
                                    primary: false,
                                    itemBuilder: (context, index) {
                                      if (index <
                                          _currentLearningMessageIndex) {
                                        return MessageCard(
                                          id: index,
                                          text: _messages[index].text,
                                          role: _messages[index].role,
                                          roleType: _messages[index].roleType,
                                          videoUrl: _messages[index].videoUrl,
                                          messageCheck: _messages[index]
                                              .checkInformation
                                              ?.messageCheck,
                                          learningStateType:
                                              LearningStateType.completed,
                                        );
                                      }
                                      return MessageCard(
                                        id: index,
                                        text: _recognizedWords,
                                        role: _messages[index].role,
                                        roleType: _messages[index].roleType,
                                        videoUrl: _messages[index].videoUrl,
                                        learningStateType: _learningStateType,
                                        messageCheck: _messages[index]
                                            .checkInformation
                                            ?.messageCheck,
                                        onPressedRerecord: () {
                                          setState(() {
                                            _recognizedWords = '';
                                            _learningStateType =
                                                LearningStateType
                                                    .beforeRecorded;
                                          });
                                        },
                                        onPressedCheck: () async {
                                          _messages[_currentLearningMessageIndex]
                                                  .checkInformation =
                                              await LearningService
                                                  .checkMessageWith(
                                                      _recognizedWords,
                                                      _messages[index].text);

                                          setState(() {
                                            _learningStateType =
                                                LearningStateType.corrected;
                                          });
                                        },
                                        onPressedComplete: () {
                                          setState(() {
                                            _recognizedWords = '';
                                            if (!_messages[
                                                    _currentLearningMessageIndex]
                                                .checkInformation!
                                                .isCorrect) {
                                              _wrongSentences.add(_messages[
                                                  _currentLearningMessageIndex]);
                                            }
                                            _learnedSentenceCount++;
                                            if (_messages.length - 1 >
                                                _currentLearningMessageIndex) {
                                              _currentLearningMessageIndex++;
                                              _setVideo(_messages[
                                                      _currentLearningMessageIndex]
                                                  .videoUrl);
                                              _learningStateType =
                                                  LearningStateType
                                                      .beforeRecorded;
                                            } else {
                                              _learningStateType =
                                                  LearningStateType.completed;
                                              _stopTimer();
                                            }
                                          });
                                        },
                                      );
                                    },
                                    separatorBuilder: (context, index) {
                                      return const SizedBox(
                                        height: 20,
                                      );
                                    },
                                    itemCount:
                                        _currentLearningMessageIndex + 1),
                                if (_learningStateType ==
                                    LearningStateType.completed)
                                  const Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      SizedBox(
                                        height: 32,
                                      ),
                                      Finished(),
                                    ],
                                  ),
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
              ),
            ),
          );
  }
}

class Finished extends StatelessWidget {
  const Finished({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 24,
      ),
      decoration: BoxDecoration(
        color: AppColor.grayScale.g100,
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      child: Text(
        "학습이 종료되었어요!\n상단에 있는 학습 종료 버튼을 눌러주세요.",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16,
          fontFamily: FontType.pretendard.name,
          fontVariations: const [FontVariation('wght', 500)],
          color: AppColor.grayScale.g600,
          height: 1.55,
        ),
      ),
    );
  }
}
