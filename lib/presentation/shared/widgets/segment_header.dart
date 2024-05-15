import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SegmentHeader extends StatelessWidget {
  final String heading;
  final TextStyle? headingStyle;
  final Function? action;
  final Widget? actionButton;

  const SegmentHeader({
    super.key,
    required this.heading,
    this.headingStyle,
    this.action,
    this.actionButton,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Text(
            heading,
            style: headingStyle ?? theme.textTheme.displayMedium,
          ),
        ),
        action != null
            ? (actionButton ??
                TextButton(
                  onPressed: action!(),
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(EdgeInsets.zero),
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "SEE ALL",
                        style: theme.textTheme.bodySmall!.copyWith(
                          color: Colors.blue[800],
                        ),
                      ),
                      SvgPicture.asset(
                        "assets/icons/chervon_right_icon.svg",
                        color: Colors.blue[600],
                        width: 20,
                      ),
                    ],
                  ),
                ))
            : const SizedBox.shrink(),
      ],
    );
  }
}
