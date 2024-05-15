import 'package:lexa/data/models/chat_room.model.dart';

class ChatState {
  final Map<String, ChatRoom> chatRoomGraph;
  String? currentNode;

  ChatState({
    this.currentNode,
    Map<String, ChatRoom>? chatRoomGraph,
  }) : chatRoomGraph = chatRoomGraph ?? {};

  ChatRoom? getNode(String? roomId) {
    return chatRoomGraph[roomId];
  }

  ChatRoom? getCurrentNode() {
    return chatRoomGraph[currentNode];
  }

  ChatState addNode(ChatRoom node) {
    chatRoomGraph[node.id] = node;
    currentNode = node.id;
    return this;
  }

  ChatState removeNode(String roomId) {
    chatRoomGraph.remove(roomId);
    return this;
  }

  ChatState updateNode(ChatRoom newNode) {
    final roomId = newNode.id;
    if (chatRoomGraph.containsKey(roomId) && newNode != chatRoomGraph[roomId]) {
      chatRoomGraph[roomId] = newNode;
      currentNode = newNode.id;
    }

    return this;
  }

  void printGraph() {
    print("Tree length: ${chatRoomGraph.length}");
    chatRoomGraph.forEach((roomId, node) {
      print("Room ID: $roomId -> ${node.toString()}");
    });
  }

  ChatState copyWith({
    Map<String, ChatRoom>? chatRoomGraph,
    String? currentNode,
  }) {
    return ChatState(
      chatRoomGraph: chatRoomGraph ?? this.chatRoomGraph,
      currentNode: currentNode ?? this.currentNode,
    );
  }
}
