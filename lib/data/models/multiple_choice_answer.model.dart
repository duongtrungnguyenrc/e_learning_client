import 'dart:convert';

import 'package:lexa/data/models/base.model.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class MultipleChoiceAnswer extends BaseModel{
  String content;
  bool isTrue;

  MultipleChoiceAnswer({
    required super.id,
    required this.content,
    required this.isTrue,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'content': content,
      'isTrue': isTrue,
    };
  }

  factory MultipleChoiceAnswer.fromMap(Map<String, dynamic> map) {
    return MultipleChoiceAnswer(
      id: map['_id'].toString(),
      content: map['content'].toString(),
      isTrue: map['isTrue'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory MultipleChoiceAnswer.fromJson(String source) =>
      MultipleChoiceAnswer.fromMap(json.decode(source) as Map<String, dynamic>);
}
