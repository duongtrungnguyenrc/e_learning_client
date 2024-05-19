// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class LearningEvent {}

class CreateLearningSession extends LearningEvent {
  String topicId;
  String method;

  CreateLearningSession({
    required this.topicId,
    required this.method,
  });
}

class LoadLearningHistory extends LearningEvent {
  String? topicId;
  LoadLearningHistory({
    required this.topicId,
  });
}

class LearningVocabularyRecord extends LearningEvent {
  final String topicId;
  final String? vocabularyId;
  final String? sessionId;
  final String? answer;
  final bool istrue;

  LearningVocabularyRecord(
    this.vocabularyId,
    this.sessionId,
    this.answer,
    this.istrue,
    this.topicId,
  );
}
