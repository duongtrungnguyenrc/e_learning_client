import 'package:lexa/core/commons/constant.dart';
import 'package:flutter/material.dart';

class HorizontalListFilterItem extends StatelessWidget {
  final String itemName;
  final bool isSelected;
  final Function onSelected;

  const HorizontalListFilterItem({
    super.key,
    required this.itemName,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelected(),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: isSelected ? ColorConstants.green : ColorConstants.primaryGrey,
          border: isSelected ? Border.all(color: ColorConstants.primaryGrey) : Border.all(width: 0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 3,
            horizontal: 10,
          ),
          child: Text(
            itemName,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}
