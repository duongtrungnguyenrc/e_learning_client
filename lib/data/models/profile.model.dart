// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:lexa/data/models/activity.model.dart';
import 'package:lexa/data/models/base.model.dart';
import 'package:lexa/data/models/topic.model.dart';
import 'package:lexa/data/models/user.model.dart';

class Profile extends BaseModel {
  final String avatar;
  final String name;
  final String email;
  final String phone;
  final int topicCount;
  final int followerCount;
  final int archivementCount;
  final List<Topic> topics;
  final List<Activity> activities;
  final List<User> followers;

  Profile({
    required super.id,
    required this.avatar,
    required this.name,
    required this.email,
    required this.phone,
    this.topicCount = 0,
    this.followerCount = 0,
    this.archivementCount = 0,
    this.topics = const [],
    this.activities = const [],
    this.followers = const [],
  });

  Profile copyWith({
    String? avatar,
    String? name,
    String? email,
    String? phone,
    int? topicCount,
    int? followerCount,
    int? archivementCount,
    List<Topic>? topics,
    List<Activity>? activities,
    List<User>? followers,
  }) {
    return Profile(
      id: id,
      avatar: avatar ?? this.avatar,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      topicCount: topicCount ?? this.topicCount,
      followerCount: followerCount ?? this.followerCount,
      archivementCount: archivementCount ?? this.archivementCount,
      topics: topics ?? this.topics,
      activities: activities ?? this.activities,
      followers: followers ?? this.followers,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Profile &&
        other.id == id &&
        other.avatar == avatar &&
        other.name == name &&
        other.email == email &&
        other.phone == phone &&
        other.topicCount == topicCount &&
        other.followerCount == followerCount &&
        other.archivementCount == archivementCount;
    // listEquals(other.topics, topics);
  }

  bool listEquals(List a, List b) {
    if (identical(a, b)) return true;
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }

  @override
  int get hashCode =>
      id.hashCode ^ avatar.hashCode ^ name.hashCode ^ email.hashCode;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'avatar': avatar,
      'name': name,
      'email': email,
      'phone': phone,
      'topics': topics,
      'followers': followers,
      'topicCount': topicCount,
      'followerCount': followerCount,
      'archivementCount': archivementCount,
    };
  }

  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
      id: map['_id'].toString(),
      avatar: map['avatar'].toString(),
      name: map['name'].toString(),
      email: map['email'].toString(),
      phone: map['phone'].toString(),
      topics: map['topics'] != null && map['topics'] is List
          ? (map['topics'] as List<dynamic>)
              .map(
                (topic) => Topic.fromMap(topic),
              )
              .toList()
          : [],
      followers: map['followers'] != null && map['followers'] is List
          ? (map['followers'] as List<dynamic>)
              .map(
                (user) => User.fromMap(user),
              )
              .toList()
          : [],
      archivementCount:
          map['archivementCount'] != null ? map['archivementCount'] as int : 0,
      topicCount: map['topic'] != null ? map['topic'] as int : 0,
      followerCount:
          map['followerCount'] != null ? map['followerCount'] as int : 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Profile.fromJson(String source) =>
      Profile.fromMap(json.decode(source) as Map<String, dynamic>);
}
