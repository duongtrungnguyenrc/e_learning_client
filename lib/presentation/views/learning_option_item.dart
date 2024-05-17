import 'package:lexa/core/commons/constant.dart';
import 'package:lexa/presentation/views/svg_icon.dart';
import 'package:flutter/material.dart';

class LearningOptionItem extends StatelessWidget {
  final String iconPath;
  final String name;
  final VoidCallback onTap;

  const LearningOptionItem({
    super.key,
    required this.iconPath,
    required this.name,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      splashColor: ColorConstants.primaryGrey,
      child: Container(
          decoration: BoxDecoration(
            color: ColorConstants.white,
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
            border: Border.all(
              width: 1,
              color: ColorConstants.primaryGrey,
            )
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              children: [
                SvgIcon(
                  assetUrl: iconPath,
                  size: 24,
                  color: ColorConstants.primary,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
          ),
        ),
    );
  }
}
