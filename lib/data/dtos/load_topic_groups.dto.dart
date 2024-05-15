// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:lexa/data/models/group.model.dart';

class LoadTopicGroupsDto {
  final List<Group> groups;

  LoadTopicGroupsDto({required this.groups});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'groups': groups.map((x) => x.toMap()).toList(),
    };
  }

  factory LoadTopicGroupsDto.fromMap(Map<String, dynamic> map) {
    return LoadTopicGroupsDto(
      groups: (map['groups'] as List<dynamic>)
          .map(
            (group) => Group.fromMap(group),
          )
          .toList(),
    );
  }

  String toJson() => json.encode(toMap());

  factory LoadTopicGroupsDto.fromJson(String source) =>
      LoadTopicGroupsDto.fromMap(json.decode(source) as Map<String, dynamic>);
}
