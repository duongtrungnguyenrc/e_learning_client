import 'package:lexa/core/commons/constant.dart';
import 'package:lexa/presentation/views/first_step_setup_language_option.dart';
import 'package:lexa/presentation/views/first_step_setup_priority_topic_option.dart';
import 'package:flutter/material.dart';

class FirstStepSetupStep<T, K> extends StatefulWidget {
  final List<T> items;
  final String heading;
  final String subHeading;

  const FirstStepSetupStep({
    super.key,
    required this.items,
    required this.heading,
    required this.subHeading,
  });

  @override
  State<StatefulWidget> createState() => _FirstStepSetupStep<T, K>();
}

class _FirstStepSetupStep<T, K> extends State<FirstStepSetupStep<T, K>> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            Text(
              widget.heading,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: ColorConstants.black,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              widget.subHeading,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                fontFamily: "Mulish",
                color: ColorConstants.primaryGray,
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: ListView.separated(
              itemCount: widget.items.length,
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                if (K == FirstStepSetupLanguageOption) {
                  return FirstStepSetupLanguageOption(
                    name: widget.items[index] as String,
                    nativeName: widget.items[index] as String,
                  );
                } else if (K == FirstStepSetupPriorityTopicOption) {
                  return Container();
                } else {
                  return Container();
                }
              },
            ),
          ),
        )
      ],
    );
  }
}
