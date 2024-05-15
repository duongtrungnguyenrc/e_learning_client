import 'package:lexa/core/commons/constant.dart';
import 'package:lexa/core/commons/button_size.dart';
import 'package:flutter/material.dart';

enum PrimaryButtonStyle { outlined, contained }

class PrimaryButton extends StatelessWidget {
  final Color? backgroundColor;
  final String? text;
  final Color? textColor;
  final Color? overlayColor;
  final Color? outlineColor;
  final double? textSize;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;
  final double? size;
  final Widget? child;
  final VoidCallback onPressed;
  final PrimaryButtonStyle style;
  final Widget? icon;

  const PrimaryButton({
    super.key,
    this.backgroundColor,
    this.text,
    this.textColor,
    this.outlineColor,
    this.textSize,
    this.padding,
    this.borderRadius,
    required this.onPressed,
    this.child,
    this.overlayColor,
    this.size,
    this.icon,
    this.style = PrimaryButtonStyle.contained,
  });

  @override
  Widget build(BuildContext context) {
    if (style == PrimaryButtonStyle.outlined) {
      return OutlinedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          padding: MaterialStateProperty.all(
            padding ??
                const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 10.0),
              side: BorderSide(
                width: 1, // Đặt độ rộng của đường viền
                color: outlineColor ?? Colors.transparent,
              ),
            ),
          ),
          minimumSize: MaterialStateProperty.all(
            Size(size ?? ButtonSize.auto, double.minPositive),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) icon!,
            if (icon != null)
              const SizedBox(
                width: 10,
              ),
            child ??
                Text(
                  text ?? "Button",
                  style: TextStyle(
                    fontSize: textSize ?? 16,
                    fontWeight: FontWeight.bold,
                    color: textColor ?? ColorConstants.primary,
                  ),
                ),
          ],
        ),
      );
    } else {
      // Nếu style không phải outlined, sử dụng ElevatedButton
      return ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          padding: MaterialStateProperty.all(
            padding ??
                const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 10.0),
            ),
          ),
          minimumSize: MaterialStateProperty.all(
            Size(size ?? ButtonSize.auto, double.minPositive),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(
            backgroundColor ??
                (style == PrimaryButtonStyle.contained
                    ? ColorConstants.primary
                    : ColorConstants.white),
          ),
          overlayColor: MaterialStateProperty.all<Color>(
            overlayColor ?? ColorConstants.lightPrimary,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) icon!,
            if (icon != null)
              const SizedBox(
                width: 10,
              ),
            child ??
                Text(
                  text ?? "Button",
                  style: TextStyle(
                    fontSize: textSize ?? 16,
                    fontWeight: FontWeight.bold,
                    color: textColor ?? ColorConstants.white,
                  ),
                ),
          ],
        ),
      );
    }
  }
}
