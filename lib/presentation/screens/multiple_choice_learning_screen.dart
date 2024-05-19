import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lexa/core/commons/constant.dart';
import 'package:lexa/data/models/topic.model.dart';
import 'package:lexa/domain/business/blocs/learning.bloc.dart';
import 'package:lexa/domain/business/events/learning_bloc.event.dart';
import 'package:lexa/domain/utils/text_to_speech.utils.dart';
import 'package:lexa/presentation/screens/learning_summary_screen.dart';
import 'package:lexa/presentation/views/learning_header.dart';
import 'package:lexa/presentation/views/learning_step_control_segment.dart';
import 'package:lexa/presentation/views/multiple_choice_picker_segment.dart';
import 'package:flutter/material.dart';

class MultipleChoiceLearningScreen extends StatefulWidget {
  final Topic topic;
  const MultipleChoiceLearningScreen({super.key, required this.topic});

  @override
  State<MultipleChoiceLearningScreen> createState() =>
      _MultipleChoiceLearningScreenState();
}

class _MultipleChoiceLearningScreenState
    extends State<MultipleChoiceLearningScreen> {
  final PageController _pageController = PageController();
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
    final thumbnailHeight = MediaQuery.of(context).size.height / 4 - 10;

    return Scaffold(
      backgroundColor: ColorConstants.white,
      appBar: LearningHeader(
        progress: _currentIndex,
        count: vocabularies.length,
      ),
      body: SafeArea(
        child: PageView.builder(
          itemCount: vocabularies.length,
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => SingleChildScrollView(
            controller: ScrollController(),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: CachedNetworkImage(
                      fit: BoxFit.fill,
                      imageUrl:
                          "https://funix.edu.vn/wp-content/uploads/2023/05/How-to-Learn-English-Speaking-at-Home-960x540.jpeg",
                      height: thumbnailHeight,
                      placeholder: (context, url) => skeleton(
                        double.infinity,
                        thumbnailHeight,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "The meaning of word \"${vocabularies[_currentIndex].word}\" is?",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                MultipleChoicePickerSegment(
                  answers: vocabularies[_currentIndex].multipleChoiceAnswers,
                  onSelect: (answer, isTrue) {
                    _handleNextPage(answer, isTrue);
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: LearningStepControlSegment(
          onNext: () => _handleNextPage(null, true),
          onPrev: _handlePrevPage,
          onPlaySound: () => _handlePlaySound(vocabularies[_currentIndex].word),
        ),
      ),
    );
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

  void _handleNextPage(String? answer, bool isTrue) {
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
          answer ?? widget.topic.vocabularies[_currentIndex].meaning,
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
