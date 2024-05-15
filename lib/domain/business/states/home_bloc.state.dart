import 'package:lexa/data/models/activity.model.dart';
import 'package:lexa/data/models/topic.model.dart';
import 'package:lexa/data/models/user.model.dart';

class HomeBlocState {
  final List<Topic> recommendTopics;
  final List<User> topAuthors;
  final List<Activity> activities;

  HomeBlocState({
    this.recommendTopics = const [],
    this.topAuthors = const [],
    this.activities = const [],
  });

  HomeBlocState copyWith({
    List<Topic>? recommendTopics,
    List<User>? topAuthors,
    List<Activity>? activities,
  }) {
    return HomeBlocState(
      recommendTopics: recommendTopics ?? this.recommendTopics,
      topAuthors: topAuthors ?? this.topAuthors,
      activities: activities ?? this.activities,
    );
  }
}
