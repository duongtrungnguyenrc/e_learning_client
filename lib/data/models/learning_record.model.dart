// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:lexa/data/models/base.model.dart';
import 'package:lexa/data/models/vocabulary.model.dart';

class LearningRecord extends BaseModel {
  final dynamic vocabulary;
  final String answer;
  final bool isTrue;

  LearningRecord({
    required super.id,
    required this.vocabulary,
    required this.answer,
    required this.isTrue,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'vocabulary': vocabulary.toMap(),
      'answer': answer,
      'isTrue': isTrue,
    };
  }

  factory LearningRecord.fromMap(Map<String, dynamic> map) {
    return LearningRecord(
      id: map['_id'].toString(),
      vocabulary: map['vocabulary'] is Map<String, dynamic>
          ? Vocabulary.fromMap(map['vocabulary'])
          : map['vocabulary'].toString(),
      answer: map['answer'].toString(),
      isTrue: map['isTrue'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory LearningRecord.fromJson(String source) =>
      LearningRecord.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'LearningRecord(vocabulary: $vocabulary, answer: $answer, isTrue: $isTrue)';
}
