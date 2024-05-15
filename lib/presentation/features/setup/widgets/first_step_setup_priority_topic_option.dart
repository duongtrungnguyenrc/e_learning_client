import 'package:lexa/core/commons/constant.dart';
import 'package:flutter/material.dart';

class FirstStepSetupPriorityTopicOption extends StatelessWidget {
  final String name;
  final String nativeName;
  final bool? isActive;

  const FirstStepSetupPriorityTopicOption({
    super.key,
    required this.name,
    required this.nativeName,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: const Color.fromARGB(255, 245, 245, 246),
      ),
      child: Padding(
        padding: const EdgeInsets.all(13),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                
                color: ColorConstants.black,
              ),
            ),
            Text(
              nativeName,
              style: TextStyle(
                fontSize: 14,
                color: ColorConstants.primaryGray,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
