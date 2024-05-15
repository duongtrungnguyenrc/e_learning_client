class CreateLearningRecordDto {
  final String sessionId;
  final String vocabularyId;
  final bool isTrue;
  final String answer;

  CreateLearningRecordDto({
    required this.sessionId,
    required this.vocabularyId,
    required this.isTrue,
    required this.answer,
  });
}
