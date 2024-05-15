import 'package:lexa/data/dtos/create_message.dto.dart';
import 'package:lexa/data/models/message.model.dart';

class ChatEvent {}

class ConnectChatServer extends ChatEvent {}

class LoadRoom extends ChatEvent {
  final int page;
  final String receiverId;

  LoadRoom({
    required this.page,
    required this.receiverId,
  });
}

class JoinRoom extends ChatEvent {
  final String roomId;

  JoinRoom({required this.roomId});
}

class LeaveRoom extends ChatEvent {

}

class LoadMessages extends ChatEvent {
  final int page;

  LoadMessages({required this.page});
}

class SendMessage extends ChatEvent {
  final CreateMessageDto message;

  SendMessage({required this.message});
}

class ReceiveMessage extends ChatEvent {
  final Message message;

  ReceiveMessage({required this.message});
}

