import 'package:lexa/data/models/learning_session_summary.model.dart';

class LearningSummaryState {
  final bool loading;
  final Exception? exception;
  final List<LearningSessionSummary>? summary;

  LearningSummaryState({
    this.summary,
    this.loading = false,
    this.exception,
  });

  LearningSummaryState copyWith({List<LearningSessionSummary>? summary}) {
    return LearningSummaryState(
      summary: summary ?? this.summary,
    );
  }

  LearningSummaryState clear() {
    return LearningSummaryState();
  }
}
