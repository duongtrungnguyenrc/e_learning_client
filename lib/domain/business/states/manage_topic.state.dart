class TopicTreeNode {
  final String? id;
  final List<dynamic> children;
  final DateTime? updateTime;

  const TopicTreeNode({
    this.id,
    this.children = const [],
    this.updateTime,
  });

  TopicTreeNode copyWith({
    String? id,
    List<dynamic>? children,
    DateTime? updateTime,
  }) {
    return TopicTreeNode(
      id: id ?? this.id,
      children: children ?? this.children,
      updateTime: updateTime ?? this.updateTime,
    );
  }
}

class ManageTopicState {
  final List<TopicTreeNode> nodes;
  final bool isLoading;
  final Exception? exception;

  const ManageTopicState({
    this.nodes = const [],
    this.isLoading = false,
    this.exception,
  });

  ManageTopicState copyWith({
    List<TopicTreeNode>? nodes,
    Exception? exception,
  }) {
    return ManageTopicState(
      nodes: nodes ?? this.nodes,
      exception: exception ?? this.exception,
    );
  }

  ManageTopicState appendNode(TopicTreeNode node) {
    final newNodes = List.of(nodes);

    bool containsTarget = false;
    for (var dataNode in nodes) {
      if (dataNode.id == node.id) {
        containsTarget = true;
        break;
      }
    }

    if (!containsTarget) newNodes.add(node);
    return ManageTopicState(nodes: newNodes);
  }

  ManageTopicState update(TopicTreeNode? dataNode) {
    if (dataNode == null) return this;

    final newNodes = nodes.toList().map((node) {
      if (node.id == dataNode.id) {
        return dataNode;
      }
      return node;
    }).toList();

    return ManageTopicState(nodes: newNodes);
  }

  TopicTreeNode? find(String? id) {
    for (var node in nodes) {
      if (node.id == id) {
        return node;
      }
    }
    return null;
  }
}
