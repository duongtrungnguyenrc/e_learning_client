import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lexa/core/commons/constant.dart';
import 'package:lexa/data/models/topic.model.dart';
import 'package:lexa/domain/business/blocs/learning.bloc.dart';
import 'package:lexa/domain/business/events/learning_bloc.event.dart';
import 'package:lexa/presentation/screens/flash_card_learning_screen.dart';
import 'package:lexa/presentation/screens/multiple_choice_learning_screen.dart';
import 'package:lexa/presentation/views/count_down_clock.dart';

class LearningCountDownScreen extends StatefulWidget {
  final Topic topic;
  final LearningMethod learningMethod;

  const LearningCountDownScreen({
    super.key,
    required this.topic,
    required this.learningMethod,
  });

  @override
  State<LearningCountDownScreen> createState() => _LearningCountDownScreenState();
}

class _LearningCountDownScreenState extends State<LearningCountDownScreen> {
  bool _ready = false;
  Timer? _timer;

  late LearningBloc _learningBloc;

  @override
  void initState() {
    super.initState();
    _learningBloc = context.read<LearningBloc>();

    _learningBloc.add(
      CreateLearningSession(
        method: widget.learningMethod.toString(),
        topicId: widget.topic.id,
      ),
    );
  }

  Widget? _getLearningMethodStrategy() {
    switch (widget.learningMethod) {
      case LearningMethod.METHOD_FLASH_CARD:
        return FlashCardLearningPage(topic: widget.topic);
      case LearningMethod.METHOD_MULTIPLE_CHOICE:
        return const MultipleChoiceLearningPage();
      case LearningMethod.METHOD_FLASH_CARD:
        return FlashCardLearningPage(topic: widget.topic);
      default:
        return null;
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.white,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 30,
            ),
            AnimatedSwitcher(
              duration: const Duration(seconds: 1),
              child: _ready
                  ? const Text(
                      "Ready!",
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 50,
                        color: Colors.red,
                      ),
                    )
                  : CountDownClock(
                      interval: const Duration(seconds: 3),
                      onDone: () {
                        setState(() {
                          _ready = true;
                        });
                        _timer = Timer(const Duration(seconds: 1), () {
                          Widget? nextStep = _getLearningMethodStrategy();

                          if (nextStep != null) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => nextStep,
                              ),
                            );
                          }
                        });
                      },
                      textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 100,
                        color: ColorConstants.primary,
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
