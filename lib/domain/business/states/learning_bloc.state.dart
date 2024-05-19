// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:lexa/data/models/learning_record.model.dart';
import 'package:lexa/data/models/learning_session.model.dart';
import 'package:lexa/data/models/topic.model.dart';

class LearningState {
  final dynamic error;
  final bool loading;
  final Map<String, List<LearningSession>> _learningSessionGraph;

  LearningState({
    this.error,
    this.loading = false,
    Map<String, List<LearningSession>>? learningSessionGraph,
  }) : _learningSessionGraph =
            Map<String, List<LearningSession>>.from(learningSessionGraph ?? {});

  List<LearningSession>? getNode(String? id) {
    return _learningSessionGraph[id];
  }

  LearningState copyWith({
    dynamic error,
    bool? loading,
    Map<String, List<LearningSession>>? learningSessionGraph,
  }) {
    return LearningState(
      error: error ?? this.error,
      loading: loading ?? this.loading,
      learningSessionGraph: learningSessionGraph ?? _learningSessionGraph,
    );
  }

  LearningState addNode(LearningSession node) {
    final newGraph =
        Map<String, List<LearningSession>>.from(_learningSessionGraph);
    newGraph.update(node.topic.id, (sessions) => [...sessions, node],
        ifAbsent: () => [node]);
    return copyWith(learningSessionGraph: newGraph);
  }

  LearningState addRecord(String nodeId,String sessionId,LearningRecord record) {
    final newGraph =
        Map<String, List<LearningSession>>.from(_learningSessionGraph);

    if (newGraph.containsKey(nodeId)) {
      final sessions = newGraph[nodeId]!.map((session) {
        if (session.id == sessionId) {
          return session.copyWith(records: [...session.records, record]);
        }
        return session;
      }).toList();
      newGraph[nodeId] = sessions;
    }

    return copyWith(learningSessionGraph: newGraph);
  }

  LearningState addNodes(List<LearningSession> nodes) {
    final newGraph =
        Map<String, List<LearningSession>>.from(_learningSessionGraph);

    for (var node in nodes) {
      final key = node.topic is Topic ? node.topic.id : node.topic.toString();
      newGraph.update(
        key,
        (sessions) => [...sessions, node],
        ifAbsent: () => [node],
      );
    }
    return copyWith(learningSessionGraph: newGraph);
  }

  LearningState onLoading(bool loading) {
    return copyWith(loading: loading);
  }

  LearningState onError(dynamic error) {
    return copyWith(error: error);
  }

  List<LearningSession> get nodes =>
      _learningSessionGraph.values.expand((list) => list).toList();

  @override
  String toString() => 'LearningState(error: $error, loading: $loading, _learningSessionGraph: $_learningSessionGraph)';
}
