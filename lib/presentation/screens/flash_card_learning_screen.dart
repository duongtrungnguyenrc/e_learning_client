import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lexa/core/commons/constant.dart';
import 'package:lexa/domain/business/blocs/learning.bloc.dart';
import 'package:lexa/domain/business/events/learning_bloc.event.dart';
import 'package:lexa/domain/business/states/learning_bloc.state.dart';
import 'package:lexa/presentation/screens/learning_summary_screen.dart';
import 'package:lexa/presentation/views/learning_header.dart';
import 'package:lexa/presentation/views/flash_card_scheduled_review.dart';
import 'package:lexa/presentation/views/flip_card_segment.dart';
import 'package:lexa/presentation/views/flip_card_swipe_feedback.dart';
import 'package:lexa/presentation/views/learning_step_control_segment.dart';
import 'package:lexa/data/models/topic.model.dart';
import 'package:lexa/presentation/views/confirm_dialog.dart';
import 'package:lexa/presentation/views/draggable_widget.dart';
import 'package:flutter/material.dart';
import 'package:lexa/domain/utils/text_to_speech.utils.dart';

class FlashCardLearningScreen extends StatefulWidget {
  final Topic topic;

  const FlashCardLearningScreen({
    super.key,
    required this.topic,
  });

  @override
  State<FlashCardLearningScreen> createState() =>
      _FlashCardLearningScreenState();
}

class _FlashCardLearningScreenState extends State<FlashCardLearningScreen> {
  int _currentIndex = 0;
  bool _isAutomationMode = false;
  DragDirection _dragDirection = DragDirection.center;

  late Timer _automationModeTimer;
  late LearningBloc _learningBloc;

  @override
  void initState() {
    super.initState();
    _learningBloc = context.read<LearningBloc>();
    _learningBloc.add(LoadLearningHistory(topicId: widget.topic.id));
  }

  void _handlePrevPage() {
    setState(() {
      if (_currentIndex > 0) {
        _currentIndex -= 1;
        _handleSpeak();
      }
    });
  }

  void _handleNextPage(bool isDone) {
    if (_currentIndex < widget.topic.vocabularies.length - 1) {
      _learningBloc.add(
        LearningVocabularyRecord(
          widget.topic.vocabularies[_currentIndex].id,
          _learningBloc.state.getNode(widget.topic.id)?.last.id,
          widget.topic.vocabularies[_currentIndex].meaning,
          isDone,
          widget.topic.id,
        ),
      );
      setState(() {
        _currentIndex += 1;
        _handleSpeak();
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

  void _handleRepeat() {
    if (!_isAutomationMode) {
      if (_currentIndex != widget.topic.vocabularies.length - 1) {
        _startTimer();
      }
    } else {
      _stopTimer();
    }
  }

  void _startTimer() {
    setState(() {
      _isAutomationMode = true;
    });

    _automationModeTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_currentIndex == widget.topic.vocabularies.length - 1) {
        _stopTimer();
      } else {
        _handleNextPage(true);
      }
    });
  }

  void _stopTimer() {
    setState(() {
      _isAutomationMode = false;
    });
    _automationModeTimer.cancel();
  }

  void _handleSpeak() {
    TextToSpeechUtil.speak(widget.topic.vocabularies[_currentIndex].word);
  }

  void _handleBackPage() {
    showDialog(
      context: context,
      builder: (context) => ConfirmDialog(
        action: () {
          Navigator.pop(context);
        },
        title: "Notification",
        message: "Do you want exit?",
      ),
    );
  }

  @override
  void dispose() {
    _stopTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.lightGrey,
      appBar: LearningHeader(
        onBack: _handleBackPage,
        count: widget.topic.vocabularies.length,
        progress: _currentIndex,
      ),
      body: SafeArea(
        child: BlocBuilder<LearningBloc, LearningState>(
          builder: (context, state) => Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              _buildContent(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFlipCard() {
    return FlipCard(
      front: Text(
        widget.topic.vocabularies[_currentIndex].word,
        style: const TextStyle(
          fontSize: 50,
          fontWeight: FontWeight.bold,
        ),
      ),
      back: Text(
        widget.topic.vocabularies[_currentIndex].meaning,
        style: const TextStyle(
          fontSize: 50,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    void handleStopDrag() {
      setState(() {
        if (_dragDirection != DragDirection.center) {
          _handleNextPage(_dragDirection == DragDirection.right);
        }
        _dragDirection = DragDirection.center;
      });
    }

    return Expanded(
      child: Column(
        children: [
          FlashCardScheduledFeedback(
            dragDirection: _dragDirection,
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: DraggableWidget(
                feedback: FlipCardSwipeFeedback(
                  dragDirection: _dragDirection,
                ),
                onLeftDrag: () => setState(() {
                  _dragDirection = DragDirection.left;
                }),
                onRightDrag: () => setState(() {
                  _dragDirection = DragDirection.right;
                }),
                onCenterDrag: () => setState(() {
                  _dragDirection = DragDirection.center;
                }),
                onStopDrag: handleStopDrag,
                child: SizedBox(
                  width: double.infinity,
                  child: IntrinsicHeight(
                    child: _buildFlipCard(),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          LearningStepControlSegment(
            isAutomationMode: _isAutomationMode,
            onPrev: _handlePrevPage,
            onRepeat: _handleRepeat,
            onNext: () => _handleNextPage(true),
            onPlaySound: _handleSpeak,
          ),
        ],
      ),
    );
  }
}
