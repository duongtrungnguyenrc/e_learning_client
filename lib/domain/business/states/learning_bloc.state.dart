import 'package:lexa/data/models/learning_session.model.dart';

class LearningState {
  final dynamic error;
  final bool loading;
  final Map<String, LearningSession> _learningSessionGraph;

  LearningState({
    this.error,
    this.loading = false,
    Map<String, LearningSession>? learningSessionGraph,
  }) : _learningSessionGraph =
            Map<String, LearningSession>.from(learningSessionGraph ?? {});

  LearningSession? getNode(String? id) {
    return _learningSessionGraph[id];
  }

  LearningState copyWith({
    dynamic error,
    bool? loading,
    Map<String, LearningSession>? learningSessionGraph,
  }) {
    return LearningState(
      error: error ?? this.error,
      loading: loading ?? this.loading,
      learningSessionGraph: learningSessionGraph ?? _learningSessionGraph,
    );
  }

  LearningState addNode(LearningSession node) {
    final newGraph = Map<String, LearningSession>.from(_learningSessionGraph);
    newGraph[node.topic.id] = node;
    return copyWith(learningSessionGraph: newGraph);
  }

  LearningState addNodes(List<LearningSession> nodes) {
    final newGraph = Map<String, LearningSession>.from(_learningSessionGraph);
    for (var node in nodes) {
      newGraph[node.topic.id] = node;
    }
    return copyWith(learningSessionGraph: newGraph);
  }

  LearningState onLoading(bool loading) {
    return copyWith(loading: loading);
  }

  LearningState onError(dynamic error) {
    return copyWith(error: error);
  }

  List<LearningSession> get nodes => _learningSessionGraph.values.toList();
}
