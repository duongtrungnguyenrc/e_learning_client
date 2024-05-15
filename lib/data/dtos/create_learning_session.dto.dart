// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CreateLearningSessionDto {
  final String topicId;
  final String method;

  CreateLearningSessionDto(this.topicId, this.method);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'topicId': topicId,
      'method': method,
    };
  }

  factory CreateLearningSessionDto.fromMap(Map<String, dynamic> map) {
    return CreateLearningSessionDto(
      map['topicId'] as String,
      map['method'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CreateLearningSessionDto.fromJson(String source) =>
      CreateLearningSessionDto.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
