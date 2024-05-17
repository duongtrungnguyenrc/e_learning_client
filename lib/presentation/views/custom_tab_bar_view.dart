// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomTabBarView extends StatefulWidget {
  final int index;
  final List<Widget> tabs;
  const CustomTabBarView({
    Key? key,
    required this.index,
    required this.tabs,
  }) : super(key: key);

  @override
  State<CustomTabBarView> createState() => _CustomTabBarViewState();
}

class _CustomTabBarViewState extends State<CustomTabBarView> {
  Offset _offset = const Offset(0, 0);

  @override
  void didUpdateWidget(covariant CustomTabBarView oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.index > oldWidget.index) {
      setState(() {
        _offset = const Offset(-5.0, 0.0);
      });
    } else {
      setState(() {
        _offset = const Offset(5.0, 0.0);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (child, animation) {
        var tween = Tween(begin: _offset, end: Offset.zero).chain(
          CurveTween(curve: Curves.ease),
        );

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
      child: widget.tabs[widget.index],
    );
  }
}
