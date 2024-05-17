import 'package:flutter/cupertino.dart';
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
  final Widget? prefix;
  final Widget? suffix;
  final bool enabled;
  final bool loading;

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
    this.prefix,
    this.suffix,
    this.style = PrimaryButtonStyle.contained,
    this.enabled = true,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    if (style == PrimaryButtonStyle.outlined) {
      return OutlinedButton(
        onPressed: enabled ^ loading ? onPressed : null,
        style: ButtonStyle(
          padding: WidgetStateProperty.all(
            padding ??
                const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
          ),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 10.0),
              side: BorderSide(
                width: 1, // Đặt độ rộng của đường viền
                color: outlineColor ?? Colors.transparent,
              ),
            ),
          ),
          minimumSize: WidgetStateProperty.all(
            Size(size ?? ButtonSize.auto, double.minPositive),
          ),
        ),
        child: loading
            ? const CupertinoActivityIndicator(
                color: Colors.white,
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (prefix != null) prefix!,
                  if (prefix != null)
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
                  if (suffix != null)
                    const SizedBox(
                      width: 10,
                    ),
                  if (suffix != null) suffix!,
                ],
              ),
      );
    } else {
      return ElevatedButton(
        onPressed: enabled ^ loading ? onPressed : null,
        style: ButtonStyle(
          padding: WidgetStateProperty.all(
            padding ??
                const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
          ),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 10.0),
            ),
          ),
          minimumSize: WidgetStateProperty.all(
            Size(size ?? ButtonSize.auto, double.minPositive),
          ),
          backgroundColor: WidgetStateProperty.all<Color>(
            backgroundColor ??
                (style == PrimaryButtonStyle.contained
                    ? ColorConstants.primary
                    : ColorConstants.white),
          ),
          overlayColor: WidgetStateProperty.all<Color>(
            overlayColor ?? ColorConstants.lightPrimary,
          ),
        ),
        child: loading
            ? const CupertinoActivityIndicator(
                color: Colors.white,
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (prefix != null) prefix!,
                  if (prefix != null)
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
                  if (suffix != null)
                    const SizedBox(
                      width: 10,
                    ),
                  if (suffix != null) suffix!,
                ],
              ),
      );
    }
  }
}
