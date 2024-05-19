import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lexa/data/dtos/create_learning_record.dto.dart';
import 'package:lexa/data/dtos/create_learning_session.dto.dart';
import 'package:lexa/domain/business/events/learning_bloc.event.dart';
import 'package:lexa/domain/business/states/learning_bloc.state.dart';
import 'package:lexa/domain/repositories/learning.repository.dart';

class LearningBloc extends Bloc<LearningEvent, LearningState> {
  LearningBloc() : super(LearningState()) {
    on<LoadLearningHistory>((event, emit) async {
      emit(state.onLoading(true));

      await LearningRepository.getLearningHistory(event.topicId ?? "").then(
        (response) {
          emit(state.addNodes(response.data));
        },
      ).onError(
        (error, stackTrace) {
          emit(state.onError(error));
        },
      ).whenComplete(
        () {
          emit(state.onLoading(false));
        },
      );
    });

    on<CreateLearningSession>((event, emit) async {
      emit(state.onLoading(true));

      await LearningRepository.createLearningSession(
        CreateLearningSessionDto(
          event.topicId,
          event.method,
        ),
      ).then((response) {
        emit(state.addNode(response.data));
      }).catchError((error) {
        emit(state.onError(error));
      }).whenComplete(() {
        emit(state.onLoading(false));
      });
    });

    on<LearningVocabularyRecord>((event, emit) async {
      await LearningRepository.createLearningRecord(
        CreateLearningRecordDto(
          sessionId: event.sessionId ?? "",
          vocabularyId: event.vocabularyId ?? "",
          isTrue: event.istrue,
          answer: event.answer ?? "",
        ),
      ).then((response) {
        emit(
          state.addRecord(
            event.topicId,
            event.sessionId ?? "",
            response.data,
          ),
        );
      }).onError((DioException e, stackTrace) {
        print(e);
      });
    });
  }
}
