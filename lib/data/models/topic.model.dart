// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:lexa/data/models/base.model.dart';
import 'package:lexa/data/models/folder.model.dart';
import 'package:lexa/data/models/learning_session.model.dart';
import 'package:lexa/data/models/user.model.dart';
import 'package:lexa/data/models/vocabulary.model.dart';

class Topic extends BaseModel {
  String name;
  String description;
  bool visibility;
  String thumbnail;
  String createdTime;
  List<dynamic> vocabularies;
  dynamic author;
  dynamic folder;
  bool? isDownloaded;
  List<LearningSession> learningSessions = [];

  Topic({
    this.name = "",
    this.description = "",
    this.visibility = false,
    this.thumbnail = "",
    this.createdTime = "",
    this.vocabularies = const [],
    this.folder,
    dynamic author,
    super.id = "",
  }) : author = author ?? User();
  @override
  String toString() {
    return toJson();
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'visibility': visibility,
      'thumbnail': thumbnail,
      'createdTime': createdTime,
      'vocabularies': vocabularies.map((x) => x.toMap()).toList(),
      'folder': folder,
    };
  }

  String toJson() => json.encode(toMap());

  factory Topic.fromMap(Map<String, dynamic> map) {
    return Topic(
      id: map['_id'].toString(),
      name: map['name'].toString(),
      description: map['description'].toString(),
      visibility: map['visibility'] as bool,
      thumbnail: map['thumbnail'].toString(),
      createdTime: map['createdTime'].toString(),
      vocabularies: map['vocabularies'] != null && map['vocabularies'] is List
          ? (map['vocabularies'] as List<dynamic>)
              .map(
                (vocabulary) => vocabulary is Map<String, dynamic>
                    ? Vocabulary.fromMap(vocabulary)
                    : vocabulary,
              )
              .toList()
          : [],
      folder: map['folder'] is Map<String, dynamic>
          ? Folder.fromMap(map['folder'])
          : map['folder'],
      author: map['author'] is Map<String, dynamic>
          ? User.fromMap(map['author'])
          : map['author'],
    );
  }

  factory Topic.fromJson(String source) =>
      Topic.fromMap(json.decode(source) as Map<String, dynamic>);
}
