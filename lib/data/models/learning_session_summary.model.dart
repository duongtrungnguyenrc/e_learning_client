// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:lexa/data/models/base.model.dart';
import 'package:lexa/data/models/topic.model.dart';
import 'package:lexa/data/models/user.model.dart';

class LearningSessionSummary extends BaseModel {
  final String time;
  final dynamic topic;
  final User user;
  final int correctAnswers;

  LearningSessionSummary({
    required super.id,
    required this.time,
    required this.topic,
    required this.user,
    required this.correctAnswers,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'time': time,
      'topic': topic,
      'user': user.toMap(),
      'correctAnswers': correctAnswers,
    };
  }

  factory LearningSessionSummary.fromMap(Map<String, dynamic> map) {
    return LearningSessionSummary(
      id: map['_id'].toString(),
      time: map['time'].toString(),
      topic: map['topic'] != null && map['topic'] is Map<String, dynamic>
          ? Topic.fromMap(map['topic'] as Map<String, dynamic>)
          : map['topic'].toString(),
      user: User.fromMap(map['user'] as Map<String, dynamic>),
      correctAnswers: map['correctAnswers'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory LearningSessionSummary.fromJson(String source) =>
      LearningSessionSummary.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
