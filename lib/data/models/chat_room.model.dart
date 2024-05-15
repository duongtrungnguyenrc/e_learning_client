// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:lexa/data/models/base.model.dart';
import 'package:lexa/data/models/message.model.dart';
import 'package:lexa/data/models/user.model.dart';

class ChatRoom extends BaseModel {
  final List<User> users;
  final List<Message> messages;
  final int page;

  ChatRoom({
    required super.id,
    this.users = const [],
    this.messages = const [],
    this.page = 1,
  });

  ChatRoom copyWith({
    String? id,
    List<User>? users,
    List<Message>? messages,
    int? page,
  }) {
    return ChatRoom(
      id: id ?? this.id,
      users: users ?? this.users,
      messages: messages ?? this.messages,
      page: page ?? this.page,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChatRoom && other.id == id && other.page == page && listEquals(other.messages, messages);
  }

  bool listEquals(List a, List b) {
    if (identical(a, b)) return true;
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }

  @override
  int get hashCode => id.hashCode ^ page.hashCode ^ messages.hashCode ^ users.hashCode;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'users': users.map((x) => x.toMap()).toList(),
      'messages': messages.map((x) => x.toMap()).toList(),
    };
  }

  factory ChatRoom.fromMap(Map<String, dynamic> map) {
    return ChatRoom(
      id: map["_id"].toString(),
      users: map['users'] != null && map['users'] is List
          ? (map['users'] as List<dynamic>)
              .map(
                (user) => User.fromMap(user),
              )
              .toList()
          : [],
      messages: map['messages'] != null && map['messages'] is List
          ? (map['messages'] as List<dynamic>)
              .map(
                (message) => Message.fromMap(message),
              )
              .toList()
          : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatRoom.fromJson(String source) => ChatRoom.fromMap(json.decode(source) as Map<String, dynamic>);
}
