import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lexa/data/dtos/create_topic.dto.dart';
import 'package:lexa/domain/business/events/create_topic_bloc.event.dart';
import 'package:lexa/domain/business/states/create_topic.state.dart';
import 'package:lexa/domain/repositories/topic.repository.dart';
import 'package:lexa/core/exceptions/network.exception.dart';

class CreateTopicBloc extends Bloc<CreateTopicEvent, CreateTopicState> {
  CreateTopicBloc() : super(CreateTopicState()) {
    on<InitNewTopic>((event, emit) {
      emit(
        state.copyWith(
          topic: CreateTopicDTO(
            data: Data(folder: event.root),
          ),
        ),
      );
    });

    on<UpdateNewTopic>((event, emit) {
      emit(state.copyWith(topic: event.topic));
    });

    on<AddVocabulary>((event, emit) {
      final copyVocabularies = List<CreateVocabularyDto>.from(state.topic.data.vocabularies);
      copyVocabularies.add(event.vocabulary);

      emit(
        state.copyWith(
          topic: state.topic.copyWith(
            data: state.topic.data.copyWith(
              vocabularies: copyVocabularies,
            ),
          ),
        ),
      );
    });

    on<SaveTopic>((event, emit) async {
      try {
        emit(state.copyWith(loading: true));
        final res = await TopicRepository.createTopic(state.topic);
        emit(CreateTopicSuccess(newTopic: res.data));
      } on NetworkException catch (e) {
        emit(CreateTopicFailed(exception: e));
      } finally {
        emit(state.copyWith(loading: false));
      }
    });
  }
}
