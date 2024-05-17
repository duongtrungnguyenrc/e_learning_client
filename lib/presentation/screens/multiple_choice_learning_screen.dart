import 'package:cached_network_image/cached_network_image.dart';
import 'package:lexa/core/commons/constant.dart';
import 'package:lexa/presentation/views/learning_header.dart';
import 'package:lexa/presentation/views/learning_step_control_segment.dart';
import 'package:lexa/presentation/views/multiple_choice_picker_segment.dart';
import 'package:flutter/material.dart';

class MultipleChoiceLearningPage extends StatelessWidget {
  const MultipleChoiceLearningPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.white,
      appBar: const LearningHeader(
        progress: 0,
        count: 1,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
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
                    height: MediaQuery.of(context).size.height / 4 - 10,
                    placeholder: (context, url) => const CircularProgressIndicator(),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "The meaning of word \"shape\" is?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const MultipleChoicePickerSegment(),
              const SizedBox(
                height: 20,
              ),
              const LearningStepControlSegment(),
            ],
          ),
        ),
      ),
    );
  }
}
