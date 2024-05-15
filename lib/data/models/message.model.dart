// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:lexa/data/models/base.model.dart';
import 'package:lexa/data/models/user.model.dart';

class Message extends BaseModel {
  final User sender;
  final String message;
  final String time;

  Message({
    required this.sender,
    required this.message,
    required this.time,
    required super.id,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Message &&
        other.id == id &&
        other.sender == sender &&
        other.message == message &&
        other.time == time;
  }

  @override
  int get hashCode => id.hashCode ^ sender.hashCode ^ message.hashCode ^ time.hashCode;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sender': sender.toMap(),
      'message': message,
      'time': time,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      id: map["_id"].toString(),
      sender: User.fromMap(map['sender'] as Map<String, dynamic>),
      message: map['message'].toString(),
      time: map['time'].toString(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) => Message.fromMap(json.decode(source) as Map<String, dynamic>);
}
