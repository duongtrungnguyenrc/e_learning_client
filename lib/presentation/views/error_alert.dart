import 'package:lexa/core/commons/constant.dart';
import 'package:lexa/core/commons/button_size.dart';
import 'package:lexa/presentation/views/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ErrorAlert extends StatelessWidget {
  final String title;
  final String errors;

  const ErrorAlert({
    super.key,
    required this.title,
    required this.errors,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ColorConstants.white,
      surfaceTintColor: ColorConstants.white,
      title: LottieBuilder.asset(
        "assets/animations/error.json",
        width: 80,
        height: 80,
        repeat: false,
      ),
      content: Wrap(
        alignment: WrapAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "$title!".toUpperCase(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                errors,
                overflow: TextOverflow.clip,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ],
          )
        ],
      ),
      titlePadding: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 15,
      ),
      contentPadding: const EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      actionsPadding: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: 20,
      ),
      actions: <Widget>[
        PrimaryButton(
          size: ButtonSize.expanded,
          backgroundColor: Colors.red[600],
          overlayColor: Colors.red[200],
          onPressed: () {
            Navigator.of(context).pop();
          },
          text: "Close",
        ),
      ],
    );
  }
}
