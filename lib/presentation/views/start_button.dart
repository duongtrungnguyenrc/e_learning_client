import 'package:lexa/core/commons/constant.dart';
import 'package:flutter/material.dart';

class StartButton extends StatefulWidget {
  final bool isActive;
  final VoidCallback action;

  const StartButton({
    super.key,
    required this.isActive,
    required this.action,
  });

  @override
  State<StartButton> createState() => _StartButtonState();
}

class _StartButtonState extends State<StartButton> {
  bool _isAnimatedComplete = false;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          widget.action();
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            ColorConstants.primary,
          ),
          elevation: MaterialStateProperty.all<double>(0),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            const EdgeInsets.all(6),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: AnimatedContainer(
            onEnd: () {
              setState(() {
                if (widget.isActive) {
                  _isAnimatedComplete = true;
                } else {
                  _isAnimatedComplete = false;
                }
              });
            },
            width: widget.isActive ? 185 : 52,
            duration: const Duration(milliseconds: 300),
            child: Row(
              mainAxisAlignment: widget.isActive
                  ? MainAxisAlignment.spaceBetween
                  : MainAxisAlignment.center,
              children: [
                Visibility(
                  visible: widget.isActive && _isAnimatedComplete,
                  child: const SizedBox(width: 13),
                ),
                Visibility(
                  visible: widget.isActive && _isAnimatedComplete,
                  child: const Text(
                    'Get started',
                    style: TextStyle(
                        color: Color(0xffFFFFFF),
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
                Visibility(
                  visible: widget.isActive && _isAnimatedComplete,
                  child: const SizedBox(width: 15),
                ), // Khoảng cách giữa icon và chữ
                Image.asset(
                  widget.isActive
                      ? "assets/icons/contained_right_arrow.png"
                      : "assets/icons/right_arrow_white.png",
                  width: 52,
                  height: 52,
                )
              ],
            ),
          ),
        ));
  }
}
