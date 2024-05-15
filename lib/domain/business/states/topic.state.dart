import 'package:equatable/equatable.dart';
import 'package:lexa/data/models/topic.model.dart';

class TopicState extends Equatable {
  final Map<String, Topic> topicGraph;

  TopicState({
    Map<String, Topic>? topicGraph,
  }) : topicGraph = topicGraph ?? {};

  Topic? getNode(String nodeId) {
    return topicGraph[nodeId];
  }

  Topic? getAuthenticatedNode() {
    if (topicGraph.isNotEmpty) {
      return topicGraph.values.first;
    } else {
      return null;
    }
  }

  TopicState addNode(Topic node) {
    final nodeId = node.id;
    topicGraph[nodeId] = node;

    return this;
  }

  TopicState removeNode(String nodeId) {
    topicGraph.remove(nodeId);
    return this;
  }

  void printGraph() {
    print("Tree length: ${topicGraph.length}");
    topicGraph.forEach((nodeId, node) {
      print("Topic ID: $nodeId -> ${node.toString()}");
    });
  }

  TopicState copyWith({
    Map<String, Topic>? topicGraph,
  }) {
    return TopicState(
      topicGraph: topicGraph ?? this.topicGraph,
    );
  }

  @override
  List<Object?> get props => [topicGraph, topicGraph.length];
}
