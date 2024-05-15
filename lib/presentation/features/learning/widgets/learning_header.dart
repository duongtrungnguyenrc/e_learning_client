import 'package:lexa/core/commons/constant.dart';
import 'package:lexa/presentation/shared/widgets/circular_icon_button.dart';
import 'package:flutter/material.dart';

class LearningHeader extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onBack;
  final int count;
  final int progress;

  const LearningHeader({
    super.key,
    this.onBack,
    required this.count,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          leading: CircularIconButton(
            iconPath: "assets/icons/x_icon.svg",
            size: 40,
            iconSize: 36,
            elevation: 0,
            background: Colors.transparent,
            onTap: () {
              onBack != null ? onBack!() : Navigator.pop(context);
            },
          ),
          title: Text(
            '$progress/$count',
            style: TextStyle(
              fontSize: 16,
              color: ColorConstants.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {},
              style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(
                ColorConstants.primaryGrey,
              )),
              child: Text(
                "Skip",
                style: TextStyle(
                  color: ColorConstants.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        TweenAnimationBuilder<double>(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          tween: Tween<double>(
            begin: 0,
            end: progress / count,
          ),
          builder: (context, value, _) => LinearProgressIndicator(
            value: value,
            color: value == 1 ? ColorConstants.green : ColorConstants.primary,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 70);
}
