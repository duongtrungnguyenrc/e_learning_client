import 'package:lexa/core/commons/constant.dart';
import 'package:flutter/material.dart';
import 'package:lexa/domain/utils/sound.utils.dart';

class FlipCard extends StatefulWidget {
  final Widget front;
  final Widget back;

  const FlipCard({
    Key? key,
    required this.front,
    required this.back,
  }) : super(key: key);

  @override
  createState() => _FlipCardState();
}

class _FlipCardState extends State<FlipCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isFront = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _flipCard() {
    if (_controller.status != AnimationStatus.forward) {
      if (_isFront) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
      _isFront = !_isFront;
    }
    SoundUtil().playSound("/sounds/flip_sound.mp3");
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _flipCard,
      child: Transform(
        transform: Matrix4.rotationY(_animation.value * 3.1415926535897932),
        alignment: Alignment.center,
        child: Center(
          child: _isFront ? _buildFront() : _buildBack(),
        ),
      ),
    );
  }

  Widget _buildFront() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: ColorConstants.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: widget.front,
      ),
    );
  }

  Widget _buildBack() {
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.rotationY(3.14),
      child: Container(
        decoration: BoxDecoration(
          color: ColorConstants.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: widget.back,
        ),
      ),
    );
  }
}
