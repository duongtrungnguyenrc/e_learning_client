// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class DestroyForgotPasswordTransactionDto {
  final String? transactionId;

  DestroyForgotPasswordTransactionDto({
    this.transactionId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'transactionId': transactionId,
    };
  }

  factory DestroyForgotPasswordTransactionDto.fromMap(Map<String, dynamic> map) {
    return DestroyForgotPasswordTransactionDto(
      transactionId: map['transactionId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory DestroyForgotPasswordTransactionDto.fromJson(String source) =>
      DestroyForgotPasswordTransactionDto.fromMap(json.decode(source) as Map<String, dynamic>);
}
