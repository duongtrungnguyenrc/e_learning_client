import 'package:lexa/presentation/views/learning_option_item.dart';
import 'package:lexa/presentation/screens/flash_card_learning_screen.dart';
import 'package:lexa/presentation/screens/multiple_choice_learning_screen.dart';
import 'package:lexa/data/models/topic.model.dart';
import 'package:lexa/presentation/views/segment_header.dart';
import 'package:flutter/material.dart';

class LearningOptionPickerSegment extends StatelessWidget {
  final Topic topic;

  const LearningOptionPickerSegment({
    super.key,
    required this.topic,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SegmentHeader(heading: "Learning options"),
        const SizedBox(
          height: 10,
        ),
        LearningOptionItem(
          iconPath: "assets/icons/flash_card_icon.svg",
          name: "Flashcards",
          onTap: () async {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FlashCardLearningPage(topic: topic),
              ),
            );
          },
        ),
        const SizedBox(
          height: 10,
        ),
        LearningOptionItem(
          iconPath: "assets/icons/multiple_choice_icon.svg",
          name: "Multiple choice",
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MultipleChoiceLearningPage(),
              ),
            );
          },
        ),
      ],
    );
  }
}
