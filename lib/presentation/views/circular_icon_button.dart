import 'package:lexa/core/commons/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CircularIconButton extends StatelessWidget {
  final String iconPath;
  final double size;
  final double? iconSize;
  final Color? iconColor;
  final Function onTap;
  final double? elevation;
  final Color? background;
  final BorderSide? borderSide;
  final bool enable;

  const CircularIconButton({
    super.key,
    required this.iconPath,
    required this.size,
    required this.onTap,
    this.iconSize,
    this.iconColor,
    this.elevation,
    this.background,
    this.borderSide,
    this.enable = true,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => enable ? onTap() : null,
      style: ButtonStyle(
        elevation: WidgetStateProperty.all(elevation == 0 ? elevation : 1),
        backgroundColor: WidgetStateProperty.all(enable
            ? background ?? ColorConstants.white
            : ColorConstants.lightGrey),
        surfaceTintColor: WidgetStateProperty.all(ColorConstants.primaryGrey),
        overlayColor: WidgetStateProperty.all(
            enable ? ColorConstants.primaryGrey : Colors.transparent),
        minimumSize: WidgetStateProperty.all(
          Size(size, size),
        ),
        maximumSize: WidgetStateProperty.all(
          Size(size, size),
        ),
        shape: WidgetStateProperty.all(
          CircleBorder(
            side: borderSide ??
                const BorderSide(
                  width: 0,
                  color: Colors.transparent,
                ),
          ),
        ),
        padding: WidgetStateProperty.all(EdgeInsets.zero),
      ),
      child: SvgPicture.asset(
        iconPath,
        fit: BoxFit.scaleDown,
        color: iconColor,
        width: iconSize ?? 16,
        height: iconSize ?? 16,
      ),
    );
  }
}
