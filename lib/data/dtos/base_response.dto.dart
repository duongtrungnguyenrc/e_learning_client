// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class BaseResponse<T, K> {
  String message;
  T data;

  BaseResponse({
    required this.message,
    required this.data,
  });

  Map<String, dynamic> toMap(Function(T) toMapT) {
    return <String, dynamic>{
      'message': message,
      'data': toMapT(data),
    };
  }

  factory BaseResponse.fromMap(
      Map<String, dynamic> map, Function(Map<String, dynamic>)? fromMapT) {
    return BaseResponse<T, K>(
      message: map['message'].toString(),
      data: map['data'] is List<dynamic>
          ? (map['data'] as List<dynamic>)
              .map<K>((item) => fromMapT!(item))
              .toList()
          : (((fromMapT != null) && (map['data'] != null))
              ? fromMapT(map['data'])
              : map['data']),
    );
  }

  String toJson() => json.encode({message, data});
}
