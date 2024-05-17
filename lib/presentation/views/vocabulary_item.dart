import 'package:lexa/core/commons/constant.dart';
import 'package:lexa/presentation/views/circular_icon_button.dart';
import 'package:lexa/presentation/views/double_text_column.dart';
import 'package:flutter/material.dart';

class VocabularyItem extends StatelessWidget {
  final String word;
  final String meaning;

  const VocabularyItem({
    super.key,
    required this.word,
    required this.meaning,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorConstants.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        border: Border.all(
          width: 1,
          color: ColorConstants.primaryGrey,
        ),
      ),
      padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          DoubleTextColumn(
            mainText: word,
            subText: meaning,
            mainTextSize: 16,
            mainTextWeight: FontWeight.w500,
            subTextSize: 14,
          ),
          Row(
            children: [
              CircularIconButton(
                size: 40,
                elevation: 0,
                borderSide: BorderSide(
                  width: 1,
                  color: ColorConstants.primaryGrey,
                ),
                iconPath: "assets/icons/sound_icon.svg",
                onTap: () async {
                  // FlutterTts flutterTts = FlutterTts();
                  // await flutterTts.speak(word);
                },
              ),
              CircularIconButton(
                size: 40,
                elevation: 0,
                borderSide: BorderSide(
                  width: 1,
                  color: ColorConstants.primaryGrey,
                ),
                iconPath: "assets/icons/star_regular_icon.svg",
                onTap: () {},
              ),
            ],
          )
        ],
      ),
    );
  }
}
