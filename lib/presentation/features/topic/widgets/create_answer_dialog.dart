import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lexa/core/commons/constant.dart';
import 'package:lexa/data/dtos/create_topic.dto.dart';
import 'package:lexa/core/commons/button_size.dart';
import 'package:lexa/presentation/shared/widgets/primary_button.dart';

class CreateAnswerDialog extends StatefulWidget {
  final Color color;
  final CreateMultipleChoiceAnswerDto? answer;
  final Function(CreateMultipleChoiceAnswerDto) onChanged;

  const CreateAnswerDialog({
    super.key,
    this.answer,
    required this.onChanged,
    required this.color,
  });

  @override
  State<CreateAnswerDialog> createState() => _CreateAnswerDialogState();
}

class _CreateAnswerDialogState extends State<CreateAnswerDialog> {
  late TextEditingController _textEditingController;
  late CreateMultipleChoiceAnswerDto _answer;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _answer = widget.answer ?? CreateMultipleChoiceAnswerDto();
    _textEditingController.text = _answer.content.isNotEmpty ? _answer.content : "";
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      surfaceTintColor: ColorConstants.white,
      backgroundColor: ColorConstants.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: IntrinsicHeight(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(children: [
            const Text(
              "Edit answer",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: widget.color,
              ),
              width: (MediaQuery.of(context).size.width - 80) / 2,
              height: (MediaQuery.of(context).size.width - 80) / 2.5,
              alignment: Alignment.center,
              child: TextField(
                autofocus: true,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ColorConstants.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
                controller: _textEditingController,
                decoration: InputDecoration(
                  hintText: widget.answer != null ? widget.answer?.content : "Answer...",
                  hintStyle: const TextStyle(color: Colors.white),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _answer = _answer.copyWith(content: value);
                  });
                },
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Correct answer",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                CupertinoSwitch(
                  value: _answer.isTrue,
                  onChanged: (isCorrect) {
                    setState(() {
                      _answer = _answer.copyWith(isTrue: isCorrect);
                    });
                  },
                )
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            PrimaryButton(
              size: ButtonSize.expanded,
              onPressed: () {
                final validateResult = _answer.validate();
                if (validateResult == null) {
                  widget.onChanged(_answer);
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        validateResult.message,
                      ),
                    ),
                  );
                }
              },
              text: "Save",
            ),
          ]),
        ),
      ),
    );
  }
}
