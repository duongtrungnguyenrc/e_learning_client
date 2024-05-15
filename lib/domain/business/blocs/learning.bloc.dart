import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lexa/data/dtos/create_learning_session.dto.dart';
import 'package:lexa/data/models/learning_session.model.dart';
import 'package:lexa/domain/business/events/learning_bloc.event.dart';
import 'package:lexa/domain/business/states/learning_bloc.state.dart';
import 'package:lexa/domain/repositories/learning.repository.dart';

class LearningBloc extends Bloc<LearningEvent, LearningState> {
  LearningBloc() : super(LearningState()) {
    on<LoadLearningHistory>((event, emit) async {
      emit(state.onLoading(true));

      await LearningRepository.getLearningHistory(event.topicId ?? "").then(
        (response) {
          emit(state.addNodes(response.data as List<LearningSession>));
        },
      ).catchError(
        (error) {
          print(error);
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
  }
}
