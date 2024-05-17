// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CreateForgotPasswordTransactionResponseDto {
  final String transactionId;

  CreateForgotPasswordTransactionResponseDto(this.transactionId);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'transactionId': transactionId,
    };
  }

  factory CreateForgotPasswordTransactionResponseDto.fromMap(
      Map<String, dynamic> map) {
    return CreateForgotPasswordTransactionResponseDto(
      map['transactionId'].toString(),
    );
  }

  String toJson() => json.encode(toMap());

  factory CreateForgotPasswordTransactionResponseDto.fromJson(String source) =>
      CreateForgotPasswordTransactionResponseDto.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
