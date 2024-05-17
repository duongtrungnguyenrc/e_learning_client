import 'package:lexa/core/commons/constant.dart';
import 'package:lexa/presentation/views/primary_button.dart';
import 'package:lexa/presentation/views/svg_icon.dart';
import 'package:flutter/material.dart';

class MultipleChoicePickerSegment extends StatefulWidget {
  final List? answers;

  const MultipleChoicePickerSegment({
    super.key,
    this.answers,
  });

  @override
  State<MultipleChoicePickerSegment> createState() => _MultipleChoicePickerSegmentState();
}

class _MultipleChoicePickerSegmentState extends State<MultipleChoicePickerSegment> {
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
                        }
                      });
                    },
                    borderRadius: 20,
                    backgroundColor: (selectedIndex == index)
                        ? Colors.green[500]
                        : (selectedIndex != -1 ? const Color.fromARGB(255, 199, 17, 4) : colors[index]),
                    overlayColor: Colors.green[300],
                    child: Text(
                      "Hello",
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
