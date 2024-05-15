import 'package:flutter/material.dart';
import 'package:lexa/data/dtos/create_topic.dto.dart';

class CreateTopicEvent {}

class InitNewTopic extends CreateTopicEvent {
  final String? root;

  InitNewTopic({required this.root});
}

class UpdateNewTopic extends CreateTopicEvent {
  final CreateTopicDTO topic;

  UpdateNewTopic({required this.topic});
}

class AddVocabulary extends CreateTopicEvent {
  final CreateVocabularyDto vocabulary;

  AddVocabulary({required this.vocabulary});
}

class SaveTopic extends CreateTopicEvent {
  final BuildContext context;

  SaveTopic({required this.context});
}