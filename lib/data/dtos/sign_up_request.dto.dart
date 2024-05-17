// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SignUpRequestDto {
  final String name;
  final String email;
  final String password;
  final String phone;

  SignUpRequestDto(
    this.name,
    this.email,
    this.password,
    this.phone,
  );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
    };
  }

  factory SignUpRequestDto.fromMap(Map<String, dynamic> map) {
    return SignUpRequestDto(
      map['name'] as String,
      map['email'] as String,
      map['password'] as String,
      map['phone'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SignUpRequestDto.fromJson(String source) =>
      SignUpRequestDto.fromMap(json.decode(source) as Map<String, dynamic>);
}
