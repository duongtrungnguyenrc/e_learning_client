// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:lexa/data/dtos/learning_record.model.dart';
import 'package:lexa/data/models/base.model.dart';
import 'package:lexa/data/models/topic.model.dart';
import 'package:lexa/data/models/user.model.dart';

class LearningSession extends BaseModel {
  final String time;
  final String method;
  final dynamic user;
  final dynamic topic;
  final List<dynamic> records;

  LearningSession({
    required super.id,
    required this.time,
    required this.method,
    required this.user,
    required this.topic,
    this.records = const [],
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'time': time,
      'method': method,
      'user': user.toMap(),
      'topic': topic.toMap(),
    };
  }

  factory LearningSession.fromMap(Map<String, dynamic> map) {
    return LearningSession(
      id: map['id'].toString(),
      time: map['time'].toString(),
      method: map['method'].toString(),
      user: map['user'] != null && map['user'] is Map<String, dynamic>
          ? User.fromMap(map['user'])
          : map['user'],
      topic: map['topic'] != null && map['topic'] is Map<String, dynamic>
          ? Topic.fromMap(map['topic'])
          : map['topic'],
      records: map['records'] != null && map['records'] is List
          ? (map['records'] as List<dynamic>)
              .map(
                (record) => record is Map<String, dynamic>
                    ? LearningRecord.fromMap(record)
                    : record,
              )
              .toList()
          : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory LearningSession.fromJson(String source) =>
      LearningSession.fromMap(json.decode(source) as Map<String, dynamic>);
}
