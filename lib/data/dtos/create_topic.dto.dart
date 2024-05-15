// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';

import 'package:lexa/core/commons/constant.dart';
import 'package:lexa/core/commons/validator.dart';

class CreateTopicDTO implements Validator {
  File? thumbnail;
  Data data;

  CreateTopicDTO({
    this.thumbnail,
    Data? data,
  }) : data = data ?? Data();

  CreateTopicDTO copyWith({
    File? thumbnail,
    Data? data,
  }) {
    return CreateTopicDTO(
      thumbnail: thumbnail ?? this.thumbnail,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'data': data.toMap(),
    };
  }

  String toJson() => json.encode(toMap());

  @override
  ValidationResult? validate() {
    return data.validate();
  }
}

class Data implements Validator {
  String name;
  String description;
  bool visibility;
  List<String> tags;
  String? group;
  String? folder;
  List<CreateVocabularyDto> vocabularies;

  Data({
    this.name = "",
    this.description = "",
    this.tags = const [],
    this.visibility = true,
    List<CreateVocabularyDto>? vocabularies,
    this.group,
    this.folder,
  }) : vocabularies = vocabularies ?? [];

  Data copyWith({
    String? name,
    String? description,
    bool? visibility,
    List<String>? tags,
    String? group,
    String? folder,
    List<CreateVocabularyDto>? vocabularies,
  }) {
    return Data(
      name: name ?? this.name,
      description: description ?? this.description,
      visibility: visibility ?? this.visibility,
      tags: tags ?? this.tags,
      group: group ?? this.group,
      folder: folder ?? this.folder,
      vocabularies: vocabularies ?? this.vocabularies,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'visibility': visibility,
      'tags': tags,
      'group': group,
      'folder': folder,
      'vocabularies': vocabularies.map((x) => x.toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());

  @override
  ValidationResult? validate() {
    if (name.isEmpty) {
      return ValidationResult(isTrue: false, message: 'Name is required.');
    }
    if (description.isEmpty) {
      return ValidationResult(isTrue: false, message: 'Description is required.');
    }
    if (tags.isEmpty) {
      return ValidationResult(isTrue: false, message: 'At least one tag is required.');
    }
    if (vocabularies.isEmpty) {
      return ValidationResult(isTrue: false, message: 'At least five vocabularies is required.');
    }
    for (var vocabulary in vocabularies) {
      var validationResult = vocabulary.validate();
      if (validationResult != null && !validationResult.isTrue) {
        return validationResult;
      }
    }
    return null;
  }
}

class CreateVocabularyDto implements Validator {
  File? thumbnail;
  String? word;
  String? meaning;
  String? description;
  List<CreateMultipleChoiceAnswerDto> multipleChoiceAnswers;
  QuestionLayout layout;

  int answerCount;

  CreateVocabularyDto({
    this.thumbnail,
    this.word,
    this.meaning,
    this.description,
    List<CreateMultipleChoiceAnswerDto>? multipleChoiceAnswers,
    this.layout = QuestionLayout.grid,
    this.answerCount = 4,
  }) : multipleChoiceAnswers = multipleChoiceAnswers ??
            List.generate(
              answerCount,
              (index) => CreateMultipleChoiceAnswerDto(),
            );

  CreateVocabularyDto copyWith({
    File? thumbnail,
    String? word,
    String? meaning,
    String? description,
    List<CreateMultipleChoiceAnswerDto>? multipleChoiceAnswers,
    QuestionLayout? layout,
    int? answerCount,
  }) {
    return CreateVocabularyDto(
      thumbnail: thumbnail ?? this.thumbnail,
      word: word ?? this.word,
      meaning: meaning ?? this.meaning,
      description: description ?? this.description,
      multipleChoiceAnswers: multipleChoiceAnswers ?? this.multipleChoiceAnswers,
      layout: layout ?? this.layout,
      answerCount: answerCount ?? this.answerCount,
    );
  }

  @override
  ValidationResult? validate() {
    if (word == null || word!.isEmpty) {
      return ValidationResult(isTrue: false, message: 'Word is required.');
    }
    if (meaning == null || meaning!.isEmpty) {
      return ValidationResult(isTrue: false, message: 'Meaning is required.');
    }
    if (multipleChoiceAnswers.isEmpty) {
      return ValidationResult(isTrue: false, message: 'At least one multiple choice answer is required.');
    }
    var isHasTrueAnswer = [];
    for (var answer in multipleChoiceAnswers) {
      if (answer.isTrue) {
        isHasTrueAnswer.add(true);
      }
      var validationResult = answer.validate();
      if (validationResult != null && !validationResult.isTrue) {
        return validationResult;
      }
    }
    if (isHasTrueAnswer.length != 1) {
      return ValidationResult(isTrue: false, message: 'Require have correct answer.');
    }
    return null;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'word': word,
      'meaning': meaning,
      'description': description,
      'multipleChoiceAnswers': multipleChoiceAnswers.map((x) => x.toMap()).toList(),
      'layout': layout.toString(),
      'answerCount': answerCount,
    };
  }

  String toJson() => json.encode(toMap());
}

class CreateMultipleChoiceAnswerDto implements Validator {
  String content;
  bool isTrue;

  CreateMultipleChoiceAnswerDto({
    this.content = '',
    this.isTrue = false,
  });

  CreateMultipleChoiceAnswerDto copyWith({String? content, bool? isTrue}) {
    return CreateMultipleChoiceAnswerDto(
      content: content ?? this.content,
      isTrue: isTrue ?? this.isTrue,
    );
  }

  @override
  ValidationResult? validate() {
    if (content.isEmpty) {
      return ValidationResult(isTrue: false, message: 'Content is required.');
    }
    return null;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'content': content,
      'isTrue': isTrue,
    };
  }

  String toJson() => json.encode(toMap());
}
