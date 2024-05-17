import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class SignInDto {
  String email;
  String password;

  SignInDto({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
    };
  }

  factory SignInDto.fromMap(Map<String, dynamic> map) {
    return SignInDto(
      email: map['email'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SignInDto.fromJson(String source) =>
      SignInDto.fromMap(json.decode(source) as Map<String, dynamic>);
}
