// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class NetworkException implements Exception {
  final int? statusCode;
  final String? message;

  NetworkException({
    this.statusCode,
    this.message,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'statusCode': statusCode,
      'message': message,
    };
  }

  factory NetworkException.fromMap(Map<String, dynamic> map) {
    return NetworkException(
      statusCode: map['statusCode'] as int,
      message: map['message'] != null ? map['message'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory NetworkException.fromJson(String source) =>
      NetworkException.fromMap(json.decode(source) as Map<String, dynamic>);
}
