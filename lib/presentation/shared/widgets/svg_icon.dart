import 'package:lexa/core/commons/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SvgIcon extends StatelessWidget {
  final String assetUrl;
  final double? size;
  final Color? color;
  final Gradient? gradient;

  const SvgIcon({
    super.key,
    required this.assetUrl,
    this.size,
    this.color,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return gradient != null
        ? ShaderMask(
            shaderCallback: (Rect bounds) {
              return gradient!.createShader(bounds);
            },
            child: SvgPicture.asset(
              assetUrl,
              width: size ?? 24,
              height: size ?? 24,
            ),
          )
        : SvgPicture.asset(
            assetUrl,
            width: size ?? 24,
            height: size ?? 24,
            color: color ?? ColorConstants.primaryGray,
          );
  }
}
