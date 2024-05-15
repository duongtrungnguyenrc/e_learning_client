// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:lexa/data/models/folder.model.dart';
import 'package:lexa/data/models/topic.model.dart';

class LoadTopicResponseDto {
  final List<Topic> topics;
  final List<Folder> folders;

  LoadTopicResponseDto({
    this.topics = const [],
    this.folders = const [],
  });

  factory LoadTopicResponseDto.fromMap(Map<String, dynamic> map) {
    return LoadTopicResponseDto(
      topics: (map['topics'] as List<dynamic>)
          .map(
            (topic) => Topic.fromMap(topic),
          )
          .toList(),
      folders: (map['folders'] as List<dynamic>)
          .map(
            (folder) => Folder.fromMap(folder),
          )
          .toList(),
    );
  }

  factory LoadTopicResponseDto.fromJson(String source) =>
      LoadTopicResponseDto.fromMap(json.decode(source) as Map<String, dynamic>);
}
