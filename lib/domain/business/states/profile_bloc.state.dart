// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:lexa/data/models/profile.model.dart';

class ProfileState {
  final Map<String, Profile> profileGraph;
  String? currentNode;

  ProfileState({
    Map<String, Profile>? profileGraph,
    this.currentNode,
  }) : profileGraph = profileGraph ?? {};

  Profile? getNode(String nodeId) {
    return profileGraph[nodeId];
  }

  Profile? getCurrentNode() {
    return profileGraph[currentNode];
  }

  Profile? getAuthenticatedNode() {
    if (profileGraph.isNotEmpty) {
      return profileGraph.values.first;
    } else {
      return null;
    }
  }

  ProfileState addNode(Profile? node) {
    final newGraph = Map<String, Profile>.from(profileGraph);
    newGraph.update(node!.id, (sessions) => node, ifAbsent: () => node);
    return copyWith(profileGraph: newGraph);
  }

  ProfileState removeNode(String nodeId) {
    profileGraph.remove(nodeId);
    return this;
  }

  void printGraph() {
    print("Tree length: ${profileGraph.length}");
    profileGraph.forEach((nodeId, node) {
      print("Room ID: $nodeId -> ${node.toString()}");
    });
  }

  ProfileState copyWith({
    Map<String, Profile>? profileGraph,
    String? currentNode,
  }) {
    return ProfileState(
      profileGraph: profileGraph ?? this.profileGraph,
      currentNode: currentNode ?? this.currentNode,
    );
  }
}
