import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lexa/core/commons/constant.dart';
import 'package:lexa/data/models/topic.model.dart';
import 'package:lexa/domain/business/blocs/learning.bloc.dart';
import 'package:lexa/domain/business/events/learning_bloc.event.dart';
import 'package:lexa/domain/utils/text_to_speech.utils.dart';
import 'package:lexa/presentation/screens/learning_summary_screen.dart';
import 'package:lexa/presentation/views/circular_icon_button.dart';
import 'package:lexa/presentation/views/learning_header.dart';
import 'package:lexa/presentation/views/learning_step_control_segment.dart';

class TypingLearningScreen extends StatefulWidget {
  final Topic topic;
  const TypingLearningScreen({super.key, required this.topic});

  @override
  State<TypingLearningScreen> createState() => _TypingLearningScreenState();
}

class _TypingLearningScreenState extends State<TypingLearningScreen> {
  final PageController _pageController = PageController();
  final TextEditingController _answerTextEditingController =
      TextEditingController();
  late final LearningBloc _learningBloc;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _learningBloc = context.read<LearningBloc>();
  }

  @override
  Widget build(BuildContext context) {
    final vocabularies = widget.topic.vocabularies;

    return Scaffold(
      backgroundColor: ColorConstants.white,
      appBar: LearningHeader(
        progress: _currentIndex,
        count: vocabularies.length,
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: vocabularies.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    "Mean of \"${vocabularies[index].word}\"?",
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        TextField(
                          controller: _answerTextEditingController,
                          decoration: InputDecoration(
                            hintText: "Your answer",
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: ColorConstants.primaryGray,
                                width: 2,
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                width: 2,
                                color: ColorConstants.primary,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          child: TextButton(
                            onPressed: () => _handleSubmitAnswer(false),
                            child: const Text("Dont know!"),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  CircularIconButton(
                    iconPath: "assets/icons/arrow_up_icon.svg",
                    size: 40,
                    onTap: () {
                      if (_answerTextEditingController.text.trim() ==
                          vocabularies[_currentIndex].meaning) {
                        return _handleSubmitAnswer(true);
                      }
                      _handleSubmitAnswer(false);
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: LearningStepControlSegment(
          onNext: () => _handleNextPage(true),
          onPrev: _handlePrevPage,
          onPlaySound: () => _handlePlaySound(vocabularies[_currentIndex].word),
        ),
      ),
    );
  }

  void _handleSubmitAnswer(bool isTrue) {
    _handleNextPage(isTrue);
    _answerTextEditingController.clear();
  }

  void _handlePlaySound(String word) {
    TextToSpeechUtil.speak(word);
  }

  void _handlePrevPage() {
    setState(() {
      if (_currentIndex > 0) {
        _currentIndex -= 1;
        // _handleSpeak();
      }
    });
  }

  void _handleNextPage(bool isTrue) {
    if (_currentIndex < widget.topic.vocabularies.length - 1) {
      _pageController.animateToPage(
        _currentIndex + 1,
        duration: const Duration(milliseconds: 200),
        curve: Curves.linear,
      );
      _learningBloc.add(
        LearningVocabularyRecord(
          widget.topic.vocabularies[_currentIndex].id,
          _learningBloc.state.getNode(widget.topic.id)?.last.id,
          _answerTextEditingController.text,
          isTrue,
          widget.topic.id,
        ),
      );
      setState(() {
        _currentIndex += 1;
      });
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LearningSummaryScreen(topicId: widget.topic.id),
        ),
      );
    }
  }
}
