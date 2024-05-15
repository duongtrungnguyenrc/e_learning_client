// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UpdateFolderDto {
  final String folder;
  final String? target;
  final String? name;

  UpdateFolderDto({
    required this.folder,
    this.target,
    this.name,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'folder': folder,
      'target': target,
      'name': name,
    };
  }

  factory UpdateFolderDto.fromMap(Map<String, dynamic> map) {
    return UpdateFolderDto(
      folder: map['folder'] as String,
      target: map['target'] != null ? map['target'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UpdateFolderDto.fromJson(String source) =>
      UpdateFolderDto.fromMap(json.decode(source) as Map<String, dynamic>);
}
