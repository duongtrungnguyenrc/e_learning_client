// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CreateLearningRecordDto {
  final String sessionId;
  final String vocabularyId;
  final bool isTrue;
  final String answer;

  CreateLearningRecordDto({
    required this.sessionId,
    required this.vocabularyId,
    required this.isTrue,
    required this.answer,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sessionId': sessionId,
      'vocabularyId': vocabularyId,
      'isTrue': isTrue,
      'answer': answer,
    };
  }

  factory CreateLearningRecordDto.fromMap(Map<String, dynamic> map) {
    return CreateLearningRecordDto(
      sessionId: map['sessionId'] as String,
      vocabularyId: map['vocabularyId'] as String,
      isTrue: map['isTrue'] as bool,
      answer: map['answer'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CreateLearningRecordDto.fromJson(String source) => CreateLearningRecordDto.fromMap(json.decode(source) as Map<String, dynamic>);
}
