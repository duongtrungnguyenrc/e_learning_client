import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lexa/core/commons/constant.dart';
import 'package:lexa/domain/business/blocs/learning.bloc.dart';
import 'package:lexa/domain/business/events/learning_bloc.event.dart';
import 'package:lexa/domain/business/states/learning_bloc.state.dart';
import 'package:lexa/presentation/features/learning/widgets/learning_header.dart';
import 'package:lexa/presentation/features/learning/widgets/flash_card_scheduled_review.dart';
import 'package:lexa/presentation/features/learning/widgets/flip_card_segment.dart';
import 'package:lexa/presentation/features/learning/widgets/flip_card_swipe_feedback.dart';
import 'package:lexa/presentation/features/learning/widgets/learning_step_control_segment.dart';
import 'package:lexa/data/models/topic.model.dart';
import 'package:lexa/presentation/shared/widgets/confirm_dialog.dart';
import 'package:lexa/utils/text_to_speech.utils.dart';
import 'package:lexa/presentation/shared/widgets/draggable_widget.dart';
import 'package:flutter/material.dart';

class FlashCardLearningPage extends StatefulWidget {
  final Topic topic;

  const FlashCardLearningPage({
    super.key,
    required this.topic,
  });

  @override
  State<FlashCardLearningPage> createState() => _FlashCardLearningPageState();
}

class _FlashCardLearningPageState extends State<FlashCardLearningPage> {
  int _currentIndex = 0;
  bool _isAutomationMode = false;
  DragDirection _dragDirection = DragDirection.center;

  late Timer _timer;
  late LearningBloc _learningBloc;

  @override
  void initState() {
    super.initState();
    _learningBloc = context.read<LearningBloc>();

    _learningBloc.add(
      CreateLearningSession(
        method: "METHOD_FLASH_CARD",
        topicId: widget.topic.id,
      ),
    );
  }

  void _handlePrevPage() {
    setState(() {
      if (_currentIndex > 0) {
        _currentIndex -= 1;
        _handleSpeak();
      }
    });
  }

  void _handleNextPage() {
    setState(() {
      if (_currentIndex < widget.topic.vocabularies.length - 1) {
        _currentIndex += 1;
        _handleSpeak();
      }
    });
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

    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_currentIndex == widget.topic.vocabularies.length - 1) {
        _stopTimer();
      } else {
        _handleNextPage();
      }
    });
  }

  void _stopTimer() {
    setState(() {
      _isAutomationMode = false;
    });
    _timer.cancel();
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
        progress: _currentIndex + 1,
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
          fontSize: 48,
          fontWeight: FontWeight.bold,
        ),
      ),
      back: Text(
        widget.topic.vocabularies[_currentIndex].meaning,
        style: const TextStyle(
          fontSize: 48,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    void handleStopDrag() {
      setState(() {
        if (_dragDirection != DragDirection.center) {
          _handleNextPage();
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
            onNext: _handleNextPage,
            onPlaySound: _handleSpeak,
          ),
        ],
      ),
    );
  }
}
