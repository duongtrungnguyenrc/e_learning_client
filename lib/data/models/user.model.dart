// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:lexa/data/models/base.model.dart';

class User extends BaseModel {
  String email;
  String name;
  String phone;
  String avatar;
  String role;

  User({
    super.id = "",
    this.email = "",
    this.name = "",
    this.phone = "",
    this.avatar = "",
    this.role = "",
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'name': name,
      'phone': phone,
      'avatar': avatar,
      'role': role,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'].toString(),
      email: map['email'].toString(),
      name: map['name'].toString(),
      phone: map['phone'].toString(),
      avatar: map['avatar'].toString(),
      role: map['role'].toString(),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(email: $email, name: $name, phone: $phone, avatar: $avatar, role: $role)';
  }
}
