import 'package:flutter/widgets.dart';

class IntroStep extends StatelessWidget {
  final String title;
  final String subtitle;
  final String thumbnailSrc;

  const IntroStep({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.thumbnailSrc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Image.asset(
        thumbnailSrc,
        height: 300,
        fit: BoxFit.contain,
      ),
      const SizedBox(
        height: 30,
      ),
      Text(
        title,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      Text(
        subtitle,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 14,
          fontFamily: "Mulish",
        ),
      )
    ]);
  }
}
