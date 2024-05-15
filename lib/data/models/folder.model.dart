// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:lexa/data/models/base.model.dart';
import 'package:lexa/data/models/user.model.dart';

class Folder extends BaseModel {
  final String name;
  final User? author;
  final Folder? root;

  Folder({required super.id, required this.name, required this.author, required this.root});

  @override
  String toString() {
    return toJson();
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'author': author?.toMap(),
      'root': root?.toMap(),
    };
  }

  factory Folder.fromMap(Map<String, dynamic> map) {
    return Folder(
      id: map['_id'].toString(),
      name: map['name'].toString(),
      author: map['author'] != null && map['author'] is Map<String, dynamic>
          ? User.fromMap(map['author'] as Map<String, dynamic>)
          : null,
      root: map['root'] != null && map['root'] is Map<String, dynamic>
          ? Folder.fromMap(map['root'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Folder.fromJson(String source) => Folder.fromMap(json.decode(source) as Map<String, dynamic>);
}
