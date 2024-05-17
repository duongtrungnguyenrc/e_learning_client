import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lexa/core/commons/constant.dart';

class CountDownClock extends StatefulWidget {
  final Duration interval;
  final String? title;
  final VoidCallback? onDone;

  const CountDownClock({
    Key? key,
    required this.interval,
    this.title,
    this.onDone,
  }) : super(key: key);

  @override
  State<CountDownClock> createState() => _CountDownClockState();
}

class _CountDownClockState extends State<CountDownClock> {
  late Duration _currentTime;
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    _currentTime = widget.interval;

    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        if (_currentTime.inSeconds > 0) {
          _currentTime -= const Duration(seconds: 1);
        } else {
          if (widget.onDone != null) widget.onDone!();
          _timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _getFormattedHours() {
    if (_currentTime.inHours != 0) {
      return '${_currentTime.inHours} : ';
    }
    return '';
  }

  String _getFormattedMinutes() {
    if (_currentTime.inMinutes != 0) {
      return '${_currentTime.inMinutes.remainder(60).toString().padLeft(2, '0')} : ';
    }
    return '';
  }

  String _getFormattedSeconds() {
    if (_currentTime.inSeconds != 0) {
      return _currentTime.inSeconds.remainder(60).toString().padLeft(2, '0');
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    String formattedTime =
        '${_getFormattedHours()}${_getFormattedMinutes()}${_getFormattedSeconds()}';

    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: ColorConstants.black,
        ),
        children: <TextSpan>[
          TextSpan(text: widget.title),
          TextSpan(
            style: TextStyle(
              color: ColorConstants.red,
            ),
            text: formattedTime,
          ),
        ],
      ),
    );
  }
}
