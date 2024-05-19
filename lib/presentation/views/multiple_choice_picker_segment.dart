import 'dart:async';

import 'package:lexa/core/commons/constant.dart';
import 'package:lexa/data/models/multiple_choice_answer.model.dart';
import 'package:lexa/domain/utils/sound.utils.dart';
import 'package:lexa/presentation/views/primary_button.dart';
import 'package:lexa/presentation/views/svg_icon.dart';
import 'package:flutter/material.dart';

class MultipleChoicePickerSegment extends StatefulWidget {
  final List<MultipleChoiceAnswer> answers;
  final Function(String answer, bool isTrue) onSelect;

  const MultipleChoicePickerSegment({
    super.key,
    required this.answers,
    required this.onSelect,
  });

  @override
  State<MultipleChoicePickerSegment> createState() =>
      _MultipleChoicePickerSegmentState();
}

class _MultipleChoicePickerSegmentState
    extends State<MultipleChoicePickerSegment> {
  int selectedIndex = -1;
  List<Color?> colors = [
    Colors.blue[500],
    Colors.orange[500],
    Colors.purple[500],
    Colors.yellow[400],
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      child: GridView.builder(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
        ),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 4,
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
                    onPressed: () {
                      setState(() {
                        if (selectedIndex == index) {
                          selectedIndex = -1;
                        } else {
                          selectedIndex = index;
                          if (widget.answers[selectedIndex].isTrue) {
                            SoundUtil().playSound("/sounds/correct_sound.mp3");
                          } else {
                            SoundUtil()
                                .playSound("/sounds/incorrect_sound.mp3");
                          }

                          Timer(const Duration(seconds: 2), () {
                            widget.onSelect(
                              widget.answers[selectedIndex].content,
                              widget.answers[selectedIndex].isTrue,
                            );
                          });
                        }
                      });
                    },
                    borderRadius: 20,
                    backgroundColor: (selectedIndex == -1)
                        ? colors[index]
                        : (widget.answers[selectedIndex].isTrue &&
                                    selectedIndex == index ||
                                widget.answers[index].isTrue
                            ? Colors.green[500]
                            : const Color.fromARGB(255, 199, 17, 4)),
                    overlayColor: Colors.blue,
                    child: Text(
                      widget.answers[index].content,
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: ColorConstants.white,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: SvgIcon(
                    assetUrl: (selectedIndex != -1) && (selectedIndex == index)
                        ? "assets/icons/circle_checkmark_icon.svg"
                        : "assets/icons/circle_xmark_icon.svg",
                    color: ColorConstants.white,
                    size: 30,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
