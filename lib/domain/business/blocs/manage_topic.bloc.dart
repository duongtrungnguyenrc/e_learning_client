// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lexa/data/models/folder.model.dart';
import 'package:lexa/data/models/topic.model.dart';
import 'package:lexa/domain/business/events/manage_topic.event.dart';
import 'package:lexa/domain/business/states/create_topic.state.dart';
import 'package:lexa/domain/business/states/manage_topic.state.dart';
import 'package:lexa/domain/repositories/topic.repository.dart';
import 'package:lexa/core/exceptions/network.exception.dart';
import 'package:lexa/domain/business/blocs/create_topic.bloc.dart';

class ManageTopicBloc extends Bloc<ManageTopicEvent, ManageTopicState> {
  final CreateTopicBloc _createTopicBloc;
  ManageTopicBloc(this._createTopicBloc) : super(const ManageTopicState()) {
    _createTopicBloc.stream.listen(
      (event) {
        if (event is CreateTopicSuccess) {
          add(LoadTopics(id: event.newTopic.folder?.id));
        }
      },
    );

    on<LoadTopics>((event, emit) async {
      try {
        final res = await TopicRepository.loadTopics(event.id);
        final children = [];
        children.addAll(res.data.folders);
        children.addAll(res.data.topics);

        final existingNode = state.find(event.id);
        if (existingNode != null) {
          final updatedNode = existingNode.copyWith(children: children);
          final updatedState = state.update(updatedNode);
          emit(updatedState);
        } else {
          emit(state.appendNode(
            TopicTreeNode(
              id: event.id,
              children: children,
            ),
          ));
        }
      } on NetworkException catch (e) {
        emit(state.copyWith(exception: e));
      }
    });

    on<CreateTopicFolder>(
      (event, emit) async {
        try {
          final res = await TopicRepository.createTopicFolder(event.data);
          final updatingNode = state.find(res.data.root?.id);
          updatingNode?.children.add(res.data);

          emit(state.update(updatingNode));
        } on NetworkException catch (e) {
          emit(state.copyWith(exception: e));
        }
      },
    );

    on<UpdateFolder>(
      (event, emit) async {
        try {
          final res = await TopicRepository.updateFolder(event.data);

          final currentNode = state.find(event.root);
          currentNode?.children.removeWhere((child) {
            return child is Folder && child.id == event.data.folder;
          });

          final targetNode = state.find(res.data.root?.id);
          if (targetNode != null) {
            targetNode.children.add(res.data);
          }

          emit(state.update(currentNode).update(targetNode));
        } on NetworkException catch (e) {
          emit(state.copyWith(exception: e));
        }
      },
    );

    on<UpdateTopic>(
      (event, emit) async {
        try {
          final res = await TopicRepository.updateTopic(event.data);

          final currentNode = state.find(event.root);
          currentNode?.children.removeWhere((child) {
            return child is Topic && child.id == event.data.id;
          });

          final targetNode = state.find(res.data.folder?.id);
          if (targetNode != null) {
            targetNode.children.add(res.data);
          }

          emit(state.update(currentNode).update(targetNode));
        } on NetworkException catch (e) {
          emit(state.copyWith(exception: e));
        }
      },
    );
  }
}
