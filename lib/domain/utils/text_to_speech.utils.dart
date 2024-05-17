// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter_tts/flutter_tts.dart';

class TextToSpeechUtil {
  static final FlutterTts _tts = FlutterTts();

  static Future<void> speak(String text) async {
    await _tts.speak(text);
  }

  static Future<void> stop() async {
    await _tts.stop();
  }
}
