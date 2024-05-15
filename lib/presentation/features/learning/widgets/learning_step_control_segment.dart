// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:lexa/presentation/shared/widgets/circular_icon_button.dart';

class LearningStepControlSegment extends StatelessWidget {
  final Function()? onNext;
  final Function()? onPrev;
  final Function()? onRepeat;
  final Function()? onPlaySound;
  final bool? isAutomationMode;

  const LearningStepControlSegment({
    Key? key,
    this.onNext,
    this.onPrev,
    this.onRepeat,
    this.onPlaySound,
    this.isAutomationMode = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CircularIconButton(
            iconPath: "assets/icons/left_arrow_icon.svg",
            size: 50,
            onTap: () => onPrev!(),
          ),
          CircularIconButton(
            iconPath: isAutomationMode! ? "assets/icons/pause_icon.svg" : "assets/icons/play_icon.svg",
            size: 50,
            onTap: () => onRepeat!(),
          ),
          CircularIconButton(
            iconPath: "assets/icons/sound_icon.svg",
            size: 50,
            onTap: () => onPlaySound!(),
          ),
          CircularIconButton(
            iconPath: "assets/icons/right_arrow_icon.svg",
            size: 50,
            onTap: () => onNext!(),
          ),
        ],
      ),
    );
  }
}
