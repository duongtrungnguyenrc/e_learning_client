import 'package:lexa/data/models/topic.model.dart';

class OfflineDataEvent {}

class SaveTopic extends OfflineDataEvent {
  final Topic topic;

  SaveTopic(this.topic);
}

class LoadSavedTopics extends OfflineDataEvent {}
