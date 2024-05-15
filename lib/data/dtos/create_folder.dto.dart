// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CreateFolderDto {
  final String name;
  final String? root;

  CreateFolderDto({required this.name, this.root});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'root': root,
    };
  }

  factory CreateFolderDto.fromMap(Map<String, dynamic> map) {
    return CreateFolderDto(
      name: map['name'].toString(),
      root: map['root'].toString(),
    );
  }

  String toJson() => json.encode(toMap());

  factory CreateFolderDto.fromJson(String source) =>
      CreateFolderDto.fromMap(json.decode(source) as Map<String, dynamic>);
}
