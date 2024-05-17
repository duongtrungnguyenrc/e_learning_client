import 'package:lexa/core/commons/constant.dart';
import 'package:flutter/material.dart';

class FlashCardScheduledFeedback extends StatelessWidget {
  final DragDirection dragDirection;

  const FlashCardScheduledFeedback({
    super.key,
    required this.dragDirection,
  });

  @override
  Widget build(BuildContext context) {
    // print(dragDirection);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Stack(
          children: [
            Container(
              width: 45,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.horizontal(
                  right: Radius.circular(20),
                ),
                color: dragDirection == DragDirection.left
                    ? const Color.fromARGB(255, 244, 222, 23)
                    : const Color.fromARGB(255, 246, 239, 178),
                border: Border.all(color: Colors.orange),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
                child: Center(
                  child: Text(
                    "0",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            AnimatedOpacity(
              opacity: dragDirection == DragDirection.left ? 1.0 : 0,
              duration: const Duration(milliseconds: 300),
              child: Container(
                width: 45,
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.horizontal(
                    right: Radius.circular(20),
                  ),
                  color: Colors.orange[600],
                  border: Border.all(color: Colors.orange),
                ),
                child: Text(
                  "+1",
                  style: TextStyle(
                    fontFamily: "Quicksand",
                    fontWeight: FontWeight.bold,
                    color: ColorConstants.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
        Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 194, 226, 252),
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 10,
            ),
            child: Text(
              "Scheduled review",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 33, 151, 248),
              ),
            ),
          ),
        ),
        Stack(
          children: [
            Container(
              width: 45,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.horizontal(
                  left: Radius.circular(20),
                ),
                color: const Color.fromARGB(255, 178, 246, 178),
                border: Border.all(color: Colors.green),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
                child: Center(
                  child: Text(
                    "0",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            AnimatedOpacity(
              opacity: dragDirection == DragDirection.right ? 1.0 : 0,
              duration: const Duration(milliseconds: 300),
              child: Container(
                width: 45,
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.horizontal(
                    left: Radius.circular(20),
                  ),
                  color: Colors.green,
                  border: Border.all(color: Colors.green),
                ),
                child: Text(
                  "+1",
                  style: TextStyle(
                    fontFamily: "Quicksand",
                    fontWeight: FontWeight.bold,
                    color: ColorConstants.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
