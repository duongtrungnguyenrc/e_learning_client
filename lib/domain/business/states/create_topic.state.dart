import 'package:flutter/material.dart';
import 'package:lexa/data/dtos/create_topic.dto.dart';
import 'package:lexa/data/models/topic.model.dart';

@immutable
class CreateTopicState {
  final CreateTopicDTO topic;
  final bool loading;
  final Exception? error;

  CreateTopicState({
    CreateTopicDTO? topic,
    this.loading = false,
    this.error,
  }) : topic = topic ?? CreateTopicDTO();

  CreateTopicState copyWith({
    CreateTopicDTO? topic,
    bool? loading,
    Exception? error,
  }) {
    return CreateTopicState(
      topic: topic ?? this.topic,
      loading: loading ?? this.loading,
      error: error ?? this.error,
    );
  }
}

class CreateTopicSuccess extends CreateTopicState {
  final Topic newTopic;

  CreateTopicSuccess({required this.newTopic});
}

class CreateTopicFailed extends CreateTopicState {
  final Exception exception;

  CreateTopicFailed({required this.exception});
}
