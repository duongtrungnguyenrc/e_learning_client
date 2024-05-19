import 'package:lexa/data/models/topic.model.dart';

class OfflineDataState {
  final Map<String, Topic> savedTopics;
  final bool loading;

  OfflineDataState({
    Map<String, Topic>? savedTopics,
    this.loading = false,
  }) : savedTopics = savedTopics ?? {};

  Topic? getNode(String id) {
    return savedTopics[id];
  }

  OfflineDataState addNode(Topic node) {
    final newGraph = Map<String, Topic>.from(savedTopics);
    newGraph.update(
      node.id,
      (_) => node,
      ifAbsent: () => node,
    );

    return copyWith(savedTopics: newGraph);
  }

  OfflineDataState removeNode(String nodeId) {
    savedTopics.remove(nodeId);
    return this;
  }

  OfflineDataState updateNode(Topic? newNode) {
    if (newNode != null) {
      final nodeId = newNode.id;
      if (savedTopics.containsKey(nodeId) && newNode != savedTopics[nodeId]) {
        savedTopics[nodeId] = newNode;
      }
    }

    return this;
  }

  void printGraph() {
    print("Tree length: ${savedTopics.length}");
    savedTopics.forEach((nodeId, node) {
      print("Room ID: $nodeId -> ${node.toString()}");
    });
  }

  OfflineDataState copyWith({Map<String, Topic>? savedTopics, bool? loading}) {
    return OfflineDataState(
      savedTopics: savedTopics ?? this.savedTopics,
      loading: loading ?? this.loading,
    );
  }
}
