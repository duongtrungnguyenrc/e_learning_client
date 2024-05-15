import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lexa/domain/business/events/chat_bloc.event.dart';
import 'package:lexa/domain/business/states/chat_bloc.state.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:lexa/core/exceptions/network.exception.dart';
import 'package:lexa/data/models/chat_room.model.dart';
import 'package:lexa/data/models/message.model.dart';
import 'package:lexa/domain/repositories/chat.repository.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  late final Socket _socket;

  ChatBloc() : super(ChatState()) {
    _socket = io(
      '${dotenv.env['SERVER_HOST']}:${dotenv.env['SERVER_SOCKET_PORT']}/chat',
      OptionBuilder()
          .setTimeout(3000)
          .setReconnectionDelay(5000)
          .disableAutoConnect()
          .setTransports(["websocket"]).build(),
    );
    on<ConnectChatServer>((event, emit) {
      _socket.connect();
    });

    _socket.onConnect((data) {});

    _socket.on("receive", (message) {
      add(ReceiveMessage(message: Message.fromMap(message)));
    });

    _socket.on("sent", (message) {
      add(ReceiveMessage(message: Message.fromMap(message)));
    });

    on<LoadRoom>((event, emit) async {
      try {
        final res = await ChatRepository.loadRoom(event.receiverId);
        final newNode = ChatRoom(
          id: res.data.id,
          users: res.data.users,
          messages: res.data.messages,
          page: state.getCurrentNode()?.page ?? 1,
        );

        print(newNode);

        emit(state.addNode(newNode));

        add(JoinRoom(roomId: res.data.id));
      } on NetworkException catch (e) {
        print(e.message);
      }
    });

    on<LoadMessages>((event, emit) async {
      try {
        final currentNode = state.currentNode;
        if (currentNode != null) {
          final res =
              await ChatRepository.loadMessages(currentNode, event.page);

          if (res.data.isNotEmpty) {
            final List<Message> updatedMessages = [
              ...res.data,
              ...state.chatRoomGraph[currentNode]?.messages ?? [],
            ];

            final updatedNode = state.chatRoomGraph[currentNode]?.copyWith(
              messages: updatedMessages,
              page: event.page,
            );

            if (updatedNode != null) {
              emit(state.copyWith(
                chatRoomGraph: {
                  ...state.chatRoomGraph,
                  currentNode: updatedNode,
                },
              ));
              state.printGraph();
            }
          }
        }
      } on NetworkException catch (e) {
        print(e.message);
      }
    });

    on<JoinRoom>((event, emit) {
      try {
        _socket.emit("join", event.roomId);
      } catch (e) {
        print(e);
      }
    });

    on<LeaveRoom>((event, emit) {
      _socket.emit("leave", state.currentNode);
      emit(state.copyWith(currentNode: null));
    });

    on<ReceiveMessage>((event, emit) {
      final currentNode = state.currentNode;
      if (currentNode != null) {
        final List<Message> updatedMessages = [
          ...state.chatRoomGraph[currentNode]?.messages ?? [],
          event.message,
        ];

        final updatedNode = state.chatRoomGraph[currentNode]?.copyWith(
          messages: updatedMessages,
        );

        if (updatedNode != null) {
          emit(state.copyWith(
            chatRoomGraph: {
              ...state.chatRoomGraph,
              currentNode: updatedNode,
            },
          ));
          state.printGraph();
        }
      }
    });

    on<SendMessage>((event, emit) {
      _socket.emit("send", event.message.toString());
    });
  }

  @override
  Future<void> close() {
    _socket.close();
    return super.close();
  }
}
