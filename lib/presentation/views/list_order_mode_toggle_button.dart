import 'package:flutter/material.dart';
import 'package:lexa/presentation/views/circular_icon_button.dart';

class ListOrderModeToggleButton extends StatelessWidget {
  final bool isList;
  final Function onTap;

  const ListOrderModeToggleButton({
    super.key,
    required this.isList,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CircularIconButton(
      iconPath: isList ? "assets/icons/list_icon.svg" : "assets/icons/table_icon.svg",
      size: 50,
      iconSize: 20,
      elevation: 0,
      onTap: onTap,
    );
  }
}
