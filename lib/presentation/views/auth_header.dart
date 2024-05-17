import 'package:flutter/material.dart';

class AuthHeader extends StatelessWidget {
  final String heading;
  final String subHeading;
  const AuthHeader({
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
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          subHeading,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        )
      ],
    );
  }
}
