import 'package:lexa/presentation/features/learning/widgets/learning_option_item.dart';
import 'package:lexa/presentation/features/learning/pages/flash_card_learning_page.dart';
import 'package:lexa/presentation/features/learning/pages/multiple_choice_learning_page.dart';
import 'package:lexa/data/models/topic.model.dart';
import 'package:lexa/presentation/shared/widgets/segment_header.dart';
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
