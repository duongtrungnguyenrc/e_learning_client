import 'dart:convert';

class CreateMessageDto {
  final String userId;
  final String roomId;
  final String message;

  CreateMessageDto({required this.userId, required this.roomId, required this.message});

  @override
  String toString() {
    return json.encode({
      "userId": userId,
      "roomId": roomId,
      "message": message,
    });
  }
}
