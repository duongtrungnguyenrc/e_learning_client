import 'package:lexa/core/commons/constant.dart';
import 'package:lexa/presentation/views/circular_icon_button.dart';
import 'package:flutter/material.dart';

class BackAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool Function()? onBack;
  final Function(DragTargetDetails<Object?>)? onDrop;
  final Color? background;
  final Color? titleColor;

  const BackAppBar({
    Key? key,
    required this.title,
    this.actions,
    this.onBack,
    this.onDrop,
    this.background,
    this.titleColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      backgroundColor: background ?? ColorConstants.white,
      surfaceTintColor: background ?? ColorConstants.white,
      centerTitle: false,
      title: Text(
        title,
        style: theme.textTheme.displayMedium?.copyWith(color: titleColor),
      ),
      leading: DragTarget(onAcceptWithDetails: (target) {
        if (onDrop != null) onDrop!(target);
      }, builder: (context, candidateData, rejectedData) {
        return CircularIconButton(
          background: Colors.transparent,
          iconPath: "assets/icons/left_arrow_icon.svg",
          size: 40,
          elevation: 0,
          iconSize: 20,
          onTap: () {
            if (onBack == null) {
              Navigator.pop(context);
            } else {
              final canBack = onBack!();
              if (canBack) Navigator.pop(context);
            }
          },
        );
      }),
      actions: [
        Padding(
          padding: const EdgeInsets.only(
            right: 10,
          ),
          child: Wrap(
            direction: Axis.horizontal,
            children: actions ?? [],
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
