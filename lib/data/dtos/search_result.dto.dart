// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:lexa/data/models/profile.model.dart';
import 'package:lexa/data/models/topic.model.dart';

class SearchResultDto {
  final List<Topic> topics;
  final List<Profile> profiles;

  SearchResultDto({
    required this.topics,
    required this.profiles,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'topics': topics.map((x) => x.toMap()).toList(),
      'profiles': profiles.map((x) => x.toMap()).toList(),
    };
  }

  factory SearchResultDto.fromMap(Map<String, dynamic> map) {
    return SearchResultDto(
      topics: map['topics'] is List<dynamic> ? map['topics'].map<Topic>((item) => Topic.fromMap(item)).toList() : [],
      profiles: map['profiles'] is List<dynamic>
          ? map['profiles'].map<Profile>((item) => Profile.fromMap(item)).toList()
          : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory SearchResultDto.fromJson(String source) =>
      SearchResultDto.fromMap(json.decode(source) as Map<String, dynamic>);
}
