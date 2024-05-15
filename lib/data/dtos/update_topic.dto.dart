// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UpdateTopicDto {
  final String id;
  final String? name;
  final String? description;
  final bool? visibility;
  final List<String>? tag;
  final String? folderId;
  final String? authorId;

  UpdateTopicDto({
    required this.id,
    this.name,
    this.description,
    this.visibility,
    this.tag,
    this.folderId,
    this.authorId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'visibility': visibility,
      'tag': tag,
      'folderId': folderId,
      'authorId': authorId,
    };
  }

  factory UpdateTopicDto.fromMap(Map<String, dynamic> map) {
    return UpdateTopicDto(
      id: map['id'] as String,
      name: map['name'] != null ? map['name'] as String : null,
      description: map['description'] != null ? map['description'] as String : null,
      visibility: map['visibility'] != null ? map['visibility'] as bool : null,
      tag: map['tag'] != null ? List<String>.from((map['tag'] as List<String>)) : null,
      folderId: map['folderId'] != null ? map['folderId'] as String : null,
      authorId: map['authorId'] != null ? map['authorId'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UpdateTopicDto.fromJson(String source) => UpdateTopicDto.fromMap(json.decode(source) as Map<String, dynamic>);
}
