import 'package:dio/dio.dart';
import 'package:lexa/core/exceptions/network.exception.dart';
import 'package:lexa/data/dtos/base_response.dto.dart';
import 'package:lexa/data/dtos/create_learning_record.dto.dart';
import 'package:lexa/data/dtos/create_learning_session.dto.dart';
import 'package:lexa/data/dtos/learning_record.model.dart';
import 'package:lexa/data/models/learning_session.model.dart';
import 'package:lexa/domain/api/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LearningRepository {
  static Future<BaseResponse<List, LearningSession>> getLearningHistory(
      String topicId) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? accessToken = sharedPreferences.getString("access_token");

    final response = await api.get(
      "/learning/history",
      queryParameters: {"topicId": topicId},
      options: Options(
        headers: {
          "Authorization": "Bearer $accessToken",
        },
      ),
    );
    return BaseResponse<List, LearningSession>.fromMap(
      response.data,
      LearningSession.fromMap,
    );
  }

  static Future<BaseResponse<LearningSession, Object>> createLearningSession(
      CreateLearningSessionDto payload) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? accessToken = sharedPreferences.getString("access_token");

    final response = await api.post(
      "/learning/session",
      options: Options(
        headers: {
          "Authorization": "Bearer $accessToken",
        },
      ),
      data: payload.toMap(),
    );
    return BaseResponse<LearningSession, Object>.fromMap(
      response.data,
      LearningSession.fromMap,
    );
  }

  static createLearningRecord(CreateLearningRecordDto payload) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String? accessToken = sharedPreferences.getString("access_token");

      final response = await api.post(
        "/learning/record",
        options: Options(
          headers: {
            "Authorization": "Bearer $accessToken",
          },
        ),
        data: payload,
      );
      return BaseResponse<LearningRecord, Object>.fromMap(
          response.data, LearningRecord.fromMap);
    } on DioException catch (e) {
      throw NetworkException(
        statusCode: e.response?.statusCode,
        message: BaseResponse.fromMap(e.response?.data, null).message,
      );
    }
  }
}
