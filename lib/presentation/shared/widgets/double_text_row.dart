import 'package:flutter/widgets.dart';
import 'package:lexa/core/commons/constant.dart';
import 'package:flutter/material.dart';

class DoubleTextRow extends StatelessWidget {
  final String mainText;
  final String subText;
  final Color? mainTextColor;
  final Color? subTextColor;
  final double? mainTextSize;
  final double? subTextSize;
  final String? mainTextFont;
  final String? subTextFont;
  final FontWeight? mainTextWeight;
  final FontWeight? subTextWeight;
  final MainAxisAlignment? mainAxisAlignment;
  final CrossAxisAlignment? crossAxisAlignment;

  const DoubleTextRow({
    super.key,
    this.mainTextSize,
    this.subTextSize,
    required this.mainText,
    required this.subText,
    this.mainTextColor,
    this.subTextColor,
    this.mainTextFont,
    this.subTextFont,
    this.mainTextWeight,
    this.subTextWeight,
    this.mainAxisAlignment,
    this.crossAxisAlignment,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
      crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
      children: [
        Text(
          mainText,
          style: TextStyle(
            fontSize: mainTextSize,
            fontWeight: mainTextWeight ?? FontWeight.bold,
            color: mainTextColor ?? ColorConstants.black,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Text(
            subText,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: subTextSize,
              fontWeight: subTextWeight ?? FontWeight.w400,
              color: subTextColor ?? ColorConstants.primaryGray,
            ),
          ),
        )
      ],
    );
  }
}
