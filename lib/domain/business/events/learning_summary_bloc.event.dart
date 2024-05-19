// ignore_for_file: public_member_api_docs, sort_constructors_first
class LearningSummaryEvent {}

class LoadSummary extends LearningSummaryEvent {
  final String topicId;

  LoadSummary({
    required this.topicId,
  });
}

class ClearSummary extends LearningSummaryEvent{}