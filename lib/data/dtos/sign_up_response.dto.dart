// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SignUpResponseDto {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String role;
  final String avatar;

  SignUpResponseDto({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.role,
    required this.avatar,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'role': role,
      'avatar': avatar,
    };
  }

  factory SignUpResponseDto.fromMap(Map<String, dynamic> map) {
    return SignUpResponseDto(
      id: map['id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      phone: map['phone'] as String,
      role: map['role'] as String,
      avatar: map['avatar'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SignUpResponseDto.fromJson(String source) =>
      SignUpResponseDto.fromMap(json.decode(source) as Map<String, dynamic>);
}
