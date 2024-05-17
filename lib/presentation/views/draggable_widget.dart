import 'package:flutter/material.dart';

class DraggableWidget extends StatefulWidget {
  final Widget child;
  final Widget feedback;
  final Function? onLeftDrag;
  final Function? onRightDrag;
  final Function? onStopDrag;
  final Function? onCenterDrag;

  const DraggableWidget({
    Key? key,
    required this.child,
    required this.feedback,
    this.onLeftDrag,
    this.onRightDrag,
    this.onStopDrag,
    this.onCenterDrag,
  }) : super(key: key);

  @override
  State<DraggableWidget> createState() => _DraggableWidgetState();
}

class _DraggableWidgetState extends State<DraggableWidget> {
  void _handleDrag(double xPosition, double centerXPoint) => setState(() {
        if (xPosition - centerXPoint <= -10) {
          widget.onLeftDrag!();
        } else if (xPosition - centerXPoint >= 10) {
          widget.onRightDrag!();
        } else {
          widget.onCenterDrag!();
        }
      });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width / 2;

    return Draggable(
      onDragUpdate: (details) {
        setState(() {
          double xOffset = details.localPosition.dx;
          _handleDrag(xOffset, screenWidth);
        });
      },
      onDragEnd: (details) {
        setState(() {
          _handleDrag(details.offset.dx, screenWidth);
        });
        widget.onStopDrag!();
      },
      feedback: widget.feedback,
      childWhenDragging: Container(),
      child: widget.child,
    );
  }
}
