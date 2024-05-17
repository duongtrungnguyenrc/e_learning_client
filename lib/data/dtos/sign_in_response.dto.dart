// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:lexa/data/models/user.model.dart';

class SignInResponseDto {
  final String accessToken;
  final String refreshToken;
  final User user;

  SignInResponseDto({
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

  factory SignInResponseDto.fromMap(Map<String, dynamic> map) {
    return SignInResponseDto(
      accessToken: map['accessToken'].toString(),
      refreshToken: map['refreshToken'].toString(),
      user: User.fromMap(map['user']),
    );
  }

  String toJson() => json.encode(toMap());

  factory SignInResponseDto.fromJson(String source) =>
      SignInResponseDto.fromMap(json.decode(source) as Map<String, dynamic>);
}
