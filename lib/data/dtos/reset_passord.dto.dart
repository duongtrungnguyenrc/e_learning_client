// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ResetPasswordDto {
  final String transactionId;
  final String otp;
  final String password;

  ResetPasswordDto(this.transactionId, this.otp, this.password);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'transactionId': transactionId,
      'otp': otp,
      'password': password,
    };
  }

  factory ResetPasswordDto.fromMap(Map<String, dynamic> map) {
    return ResetPasswordDto(
      map['transactionId'] as String,
      map['otp'] as String,
      map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ResetPasswordDto.fromJson(String source) => ResetPasswordDto.fromMap(json.decode(source) as Map<String, dynamic>);
}
