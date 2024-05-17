import 'package:lexa/core/commons/constant.dart';
import 'package:flutter/material.dart';

class FlipCardSwipeFeedback extends StatelessWidget {
  final DragDirection dragDirection;

  const FlipCardSwipeFeedback({
    super.key,
    required this.dragDirection,
  });

  @override
  Widget build(BuildContext context) {
    Color feedbackBorderColor = Colors.transparent;
    String feedbackContent = "";

    switch (dragDirection) {
      case DragDirection.left:
        feedbackBorderColor = Colors.orange;
        feedbackContent = "Still learning";
        break;
      case DragDirection.right:
        feedbackBorderColor = Colors.green;
        feedbackContent = "I Know";
        break;
      default:
        feedbackBorderColor = Colors.transparent;
        feedbackContent = "";
    }

    return Transform.rotate(
      angle: 0,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: feedbackBorderColor,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
            color: ColorConstants.white,
          ),
          width: MediaQuery.of(context).size.width * 80 / 100,
          height: MediaQuery.of(context).size.height * 60 / 100,
          child: Center(
            child: Text(
              feedbackContent,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: feedbackBorderColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
