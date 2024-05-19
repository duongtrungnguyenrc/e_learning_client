import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lexa/domain/business/events/learning_summary_bloc.event.dart';
import 'package:lexa/domain/business/states/learning_summary_bloc.state.dart';
import 'package:lexa/domain/repositories/learning.repository.dart';

class LearningSummaryBloc
    extends Bloc<LearningSummaryEvent, LearningSummaryState> {
  LearningSummaryBloc() : super(LearningSummaryState()) {
    on<LoadSummary>((event, emit) async {
      await LearningRepository.getLearningSummary(event.topicId)
          .then((response) {
        emit(state.copyWith(summary: response.data));
      }).onError((error, stackTrace) {});
    });

    on<ClearSummary>((event, emit) {
      emit(state.clear());
    });
  }
}
