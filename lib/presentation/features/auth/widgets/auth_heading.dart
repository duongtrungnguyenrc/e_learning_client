import 'package:flutter/material.dart';

class AuthHeading extends StatelessWidget {
  final String heading;
  final String subHeading;
  const AuthHeading({
    super.key,
    required this.heading,
    required this.subHeading,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          heading,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: "Roboto",
          ),
        ),
        Text(
          subHeading,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: Colors.grey,
          ),
        )
      ],
    );
  }
}
