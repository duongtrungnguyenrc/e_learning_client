// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class RegisterResponseDto {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String role;
  final String avatar;

  RegisterResponseDto({
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

  factory RegisterResponseDto.fromMap(Map<String, dynamic> map) {
    return RegisterResponseDto(
      id: map['id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      phone: map['phone'] as String,
      role: map['role'] as String,
      avatar: map['avatar'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory RegisterResponseDto.fromJson(String source) =>
      RegisterResponseDto.fromMap(json.decode(source) as Map<String, dynamic>);
}
