import 'package:flutter/material.dart';
import 'package:lexa/core/commons/constant.dart';

class InputSegment extends StatelessWidget {
  final TextEditingController inputController;
  final VoidCallback onSend;

  const InputSegment({
    super.key,
    required this.inputController,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: inputController,
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                hintText: "Aa",
                border: InputBorder.none,
                fillColor: ColorConstants.white,
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide(
                    color: ColorConstants.primaryGrey,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide(
                    color: ColorConstants.primaryGrey,
                  ),
                ),
                suffixIcon: TextButton(
                  onPressed: onSend,
                  child: Text(
                    "Send",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[600]!,
                    ),
                  ),
                )),
          ),
        ),
      ],
    );
  }
}
