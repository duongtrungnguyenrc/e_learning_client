import 'package:dio/dio.dart';
import 'package:lexa/core/commons/constant.dart';
import 'package:lexa/core/exceptions/network.exception.dart';
import 'package:lexa/data/dtos/base_response.dto.dart';
import 'package:lexa/data/models/chat_room.model.dart';
import 'package:lexa/data/models/message.model.dart';
import 'package:lexa/domain/api/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatRepository {
  static Future<BaseResponse<ChatRoom, Object>> loadRoom(String receiverId) async {
    try {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      String? accessToken = sharedPreferences.getString("access_token");

      final response = await api.get(
        "/chat/room",
        queryParameters: {
          "receiver": receiverId,
          "page": 1,
          "limit": messagesLimit,
        },
        options: Options(
          headers: {
            "Authorization": "Bearer $accessToken",
          },
        ),
      );

      return BaseResponse.fromMap(response.data, ChatRoom.fromMap);
    } on DioException catch (e) {
      throw NetworkException(
        statusCode: e.response?.statusCode,
        message: e.response?.statusMessage,
      );
    }
  }

  static Future<BaseResponse<List<Message>, Message>> loadMessages(String? roomId, int page) async {
    try {
      final response = await api.get(
        "/chat/messages",
        queryParameters: {
          "roomId": roomId,
          "page": page,
          "limit": messagesLimit,
        },
      );

      return BaseResponse.fromMap(response.data, Message.fromMap);
    } on DioException catch (e) {
      throw NetworkException(
        statusCode: e.response?.statusCode,
        message: e.response?.statusMessage,
      );
    }
  }
}
