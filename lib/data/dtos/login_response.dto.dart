// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:lexa/data/models/user.model.dart';

class LoginResponseDto {
  final String accessToken;
  final String refreshToken;
  final User user;

  LoginResponseDto({
    required this.accessToken,
    required this.refreshToken,
    required this.user,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'user': user.toMap(),
    };
  }

  factory LoginResponseDto.fromMap(Map<String, dynamic> map) {
    return LoginResponseDto(
      accessToken: map['accessToken'].toString(),
      refreshToken: map['refreshToken'].toString(),
      user: User.fromMap(map['user']),
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginResponseDto.fromJson(String source) =>
      LoginResponseDto.fromMap(json.decode(source) as Map<String, dynamic>);
}
