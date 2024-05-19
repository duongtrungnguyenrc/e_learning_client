import 'package:dio/dio.dart';
import 'package:lexa/data/dtos/base_response.dto.dart';
import 'package:lexa/data/dtos/create_learning_record.dto.dart';
import 'package:lexa/data/dtos/create_learning_session.dto.dart';
import 'package:lexa/data/models/learning_record.model.dart';
import 'package:lexa/data/models/learning_session.model.dart';
import 'package:lexa/data/models/learning_session_summary.model.dart';
import 'package:lexa/domain/api/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LearningRepository {
  static Future<BaseResponse<List<LearningSession>, LearningSession>>
      getLearningHistory(String topicId) async {
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
    return BaseResponse<List<LearningSession>, LearningSession>.fromMap(
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

  static Future<BaseResponse<LearningRecord, Object>> createLearningRecord(
      CreateLearningRecordDto payload) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? accessToken = sharedPreferences.getString("access_token");

    final response = await api.post(
      "/learning/record",
      options: Options(
        headers: {
          "Authorization": "Bearer $accessToken",
        },
      ),
      data: payload.toMap(),
    );
    return BaseResponse<LearningRecord, Object>.fromMap(
      response.data,
      LearningRecord.fromMap,
    );
  }

  static Future<
          BaseResponse<List<LearningSessionSummary>, LearningSessionSummary>>
      getLearningSummary(String topicId) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? accessToken = sharedPreferences.getString("access_token");

    final response = await api.get(
      "/learning/summary",
      options: Options(
        headers: {
          "Authorization": "Bearer $accessToken",
        },
      ),
      data: {
        "topicId": topicId,
      },
    );
    return BaseResponse<List<LearningSessionSummary>,
        LearningSessionSummary>.fromMap(
      response.data,
      LearningSessionSummary.fromMap,
    );
  }
}
