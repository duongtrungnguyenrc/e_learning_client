import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UpdateProfileDto {
  final String? name;
  final String? email;
  final String? phone;

  UpdateProfileDto({
    this.name,
    this.email,
    this.phone,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'phone': phone,
    };
  }

  factory UpdateProfileDto.fromMap(Map<String, dynamic> map) {
    return UpdateProfileDto(
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UpdateProfileDto.fromJson(String source) => UpdateProfileDto.fromMap(json.decode(source) as Map<String, dynamic>);
}
