import 'package:lexa/core/commons/constant.dart';
import 'package:lexa/data/dtos/create_topic.dto.dart';
import 'package:lexa/presentation/views/primary_button.dart';
import 'package:lexa/presentation/views/svg_icon.dart';
import 'package:flutter/material.dart';

class CreateAnswerSegment extends StatefulWidget {
  final List<CreateMultipleChoiceAnswerDto> answers;
  final Function(int) onTap;

  const CreateAnswerSegment({
    super.key,
    required this.answers,
    required this.onTap,
  });

  @override
  State<CreateAnswerSegment> createState() => _CreateAnswerSegmentState();
}

class _CreateAnswerSegmentState extends State<CreateAnswerSegment> {
  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      child: GridView.builder(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
        ),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: widget.answers.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.2,
        ),
        itemBuilder: (BuildContext context, int index) {
          return Card(
            elevation: 0,
            child: Stack(
              children: [
                SizedBox.expand(
                  child: PrimaryButton(
                    onPressed: () => widget.onTap(index),
                    borderRadius: 20,
                    backgroundColor: multipleChoiceAnswerColors[index],
                    overlayColor: Colors.green[300],
                    child: Expanded(
                      child: SingleChildScrollView(
                        child: Text(
                          widget.answers[index].content,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: ColorConstants.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                widget.answers[index].isTrue
                    ? Positioned(
                        top: 10,
                        right: 10,
                        child: SvgIcon(
                          assetUrl: "assets/icons/circle_checkmark_icon.svg",
                          color: ColorConstants.white,
                          size: 30,
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          );
        },
      ),
    );
  }
}
