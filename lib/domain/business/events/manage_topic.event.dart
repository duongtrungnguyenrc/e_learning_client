import 'package:lexa/data/dtos/create_folder.dto.dart';
import 'package:lexa/data/dtos/update_folder.dto.dart';
import 'package:lexa/data/dtos/update_topic.dto.dart';

class ManageTopicEvent {}

class LoadTopics extends ManageTopicEvent {
  final String? id;

  LoadTopics({this.id});
}

class LoadTopicGroups extends ManageTopicEvent {}

class UpdateTopic extends ManageTopicEvent {
  final UpdateTopicDto data;
  final String? root;

  UpdateTopic({
    required this.data,
    this.root,
  });
}

class CreateTopicFolder extends ManageTopicEvent {
  final CreateFolderDto data;

  CreateTopicFolder({required this.data});
}

class UpdateFolder extends ManageTopicEvent {
  final UpdateFolderDto data;
  final String? root;

  UpdateFolder({
    required this.data,
    this.root,
  });
}