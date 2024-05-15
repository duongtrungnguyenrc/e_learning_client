// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:lexa/data/models/vocabulary.model.dart';
import 'package:flutter/material.dart';

import 'package:lexa/presentation/features/learning/widgets/vocabulary_item.dart';
import 'package:lexa/data/models/topic.model.dart';
import 'package:lexa/presentation/shared/widgets/segment_header.dart';
import 'package:flutter/widgets.dart';

class VocabularyListSegment extends StatelessWidget {
  final Topic topic;

  const VocabularyListSegment({
    Key? key,
    required this.topic,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SegmentHeader(heading: "Vocabulary"),
        const SizedBox(
          height: 10,
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(
            minHeight: 0,
            maxHeight: 10000,
          ),
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) => const SizedBox(
              height: 10,
            ),
            itemBuilder: (context, index) {
              Vocabulary vocabulary = topic.vocabularies[index];
              return VocabularyItem(
                word: vocabulary.word,
                meaning: vocabulary.meaning,
              );
            },
            itemCount: topic.vocabularies.length,
          ),
        )
      ],
    );
  }
}
