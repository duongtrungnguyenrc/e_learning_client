// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:lexa/data/models/base.model.dart';
import 'package:lexa/data/models/multiple_choice_answer.model.dart';

class Vocabulary extends BaseModel {
  String word;
  String meaning;
  String description;
  String imgDescription;
  String createdTime;
  List<MultipleChoiceAnswer> multipleChoiceAnswers;

  Vocabulary({
    required super.id,
    required this.word,
    required this.meaning,
    required this.description,
    required this.imgDescription,
    required this.createdTime,
    required this.multipleChoiceAnswers,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'word': word,
      'meaning': meaning,
      'description': description,
      'imgDescription': imgDescription,
      'createdTime': createdTime,
      'multipleChoiceAnswers': multipleChoiceAnswers.map((x) => x.toMap()).toList(),
    };
  }

  factory Vocabulary.fromMap(Map<String, dynamic> map) {
    return Vocabulary(
      id: map['_id'].toString(),
      word: map['word'].toString(),
      meaning: map['meaning'].toString(),
      description: map['description'].toString(),
      imgDescription: map['imgDescription'].toString(),
      createdTime: map['createdTime'].toString(),
      multipleChoiceAnswers: map['multipleChoiceAnswers'] != null && map['multipleChoiceAnswers'] is List
          ? (map['multipleChoiceAnswers'] as List<dynamic>)
              .map((answer) => MultipleChoiceAnswer.fromMap(answer))
              .toList()
          : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory Vocabulary.fromJson(String source) => Vocabulary.fromMap(json.decode(source) as Map<String, dynamic>);
}
