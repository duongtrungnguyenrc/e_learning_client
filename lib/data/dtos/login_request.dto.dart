import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class LoginDto {
  String email;
  String password;

  LoginDto({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
    };
  }

  factory LoginDto.fromMap(Map<String, dynamic> map) {
    return LoginDto(
      email: map['email'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginDto.fromJson(String source) => LoginDto.fromMap(json.decode(source) as Map<String, dynamic>);
}
