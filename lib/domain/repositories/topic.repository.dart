import 'package:dio/dio.dart';
import 'package:lexa/domain/api/api.dart';
import 'package:lexa/data/dtos/create_folder.dto.dart';
import 'package:lexa/data/dtos/create_topic.dto.dart';
import 'package:lexa/data/dtos/load_topic_groups.dto.dart';
import 'package:lexa/data/dtos/load_topics_response.dto.dart';
import 'package:lexa/data/dtos/update_folder.dto.dart';
import 'package:lexa/data/dtos/update_topic.dto.dart';
import 'package:lexa/data/dtos/base_response.dto.dart';
import 'package:lexa/data/models/folder.model.dart';
import 'package:lexa/data/models/topic.model.dart';
import 'package:lexa/core/exceptions/network.exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TopicRepository {
  static Future<BaseResponse<LoadTopicGroupsDto, Object>> loadTopicGroups() async {
    try {
      final response = await api.get(
        "/topic/group",
      );
      return BaseResponse.fromMap(response.data, LoadTopicGroupsDto.fromMap);
    } on DioException catch (e) {
      throw NetworkException(
        statusCode: e.response?.statusCode,
        message: BaseResponse.fromMap(e.response?.data, null).message,
      );
    }
  }

  static Future<BaseResponse<Topic, Object>> loadTopic(String? id) async {
    try {
      Map<String, dynamic> queryParams = {
        if (id != null) 'id': id,
        'detail': true,
      };

      final response = await api.get(
        "/topic",
        queryParameters: queryParams,
      );
      return BaseResponse.fromMap(response.data, Topic.fromMap);
    } on DioException catch (e) {
      throw NetworkException(
        statusCode: e.response?.statusCode,
        message: BaseResponse.fromMap(e.response?.data, null).message,
      );
    }
  }

  static Future<BaseResponse<Topic, Object>> createTopic(CreateTopicDTO payload) async {
    print(payload.toJson());
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    try {
      String? accessToken = sharedPreferences.getString("access_token");

      FormData formData = FormData();

      if (payload.thumbnail != null) {
        formData.files.add(MapEntry("file", await MultipartFile.fromFile(payload.thumbnail!.path)));
      }

      formData.fields.add(MapEntry("data", payload.data.toJson()));

      var response = await api.post(
        '/topic',
        data: formData,
        options: Options(
          headers: {
            "Authorization": "Bearer $accessToken",
          },
        ),
      );

      return BaseResponse<Topic, Object>.fromMap(response.data, Topic.fromMap);
    } on DioException catch (e) {
      throw NetworkException(
        statusCode: e.response?.statusCode,
        message: BaseResponse.fromMap(e.response?.data, null).message,
      );
    }
  }

  static Future<BaseResponse<LoadTopicResponseDto, Object>> loadTopics(String? id) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    try {
      String? accessToken = sharedPreferences.getString("access_token");

      Map<String, dynamic> queryParams = {
        if (id != null) 'id': id,
      };

      final response = await api.get(
        "/topic/topics",
        queryParameters: queryParams,
        options: Options(
          headers: {
            "Authorization": "Bearer $accessToken",
          },
        ),
      );

      return BaseResponse<LoadTopicResponseDto, Object>.fromMap(response.data, LoadTopicResponseDto.fromMap);
    } on DioException catch (e) {
      throw NetworkException(
        statusCode: e.response?.statusCode,
        message: BaseResponse.fromMap(e.response?.data, null).message,
      );
    }
  }

  static Future<BaseResponse<List<Topic>, Topic>> loadRecommendTopics() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    try {
      String? accessToken = sharedPreferences.getString("access_token");

      Map<String, dynamic> queryParams = {
        'limit': 20,
      };

      final response = await api.get(
        "/topic/recommend-topics",
        queryParameters: queryParams,
        options: Options(
          headers: {
            "Authorization": "Bearer $accessToken",
          },
        ),
      );
      return BaseResponse<List<Topic>, Topic>.fromMap(response.data, Topic.fromMap);
    } on DioException catch (e) {
      throw NetworkException(
        statusCode: e.response?.statusCode,
        message: BaseResponse.fromMap(e.response?.data, null).message,
      );
    }
  }

  static Future<BaseResponse<Topic, Object>> updateTopic(UpdateTopicDto data) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      String? accessToken = sharedPreferences.getString("access_token");

      final response = await api.put(
        "/topic/topic",
        data: data.toMap(),
        options: Options(
          headers: {
            "Authorization": "Bearer $accessToken",
          },
        ),
      );

      return BaseResponse<Topic, Object>.fromMap(response.data, Topic.fromMap);
    } on DioException catch (e) {
      throw NetworkException(
        statusCode: e.response?.statusCode,
        message: BaseResponse.fromMap(e.response?.data, null).message,
      );
    }
  }

  static Future<BaseResponse<Folder, Object>> createTopicFolder(CreateFolderDto data) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    try {
      String? accessToken = sharedPreferences.getString("access_token");

      final response = await api.post(
        "/topic/folder",
        data: data.toMap(),
        options: Options(
          headers: {
            "Authorization": "Bearer $accessToken",
          },
        ),
      );

      return BaseResponse<Folder, Object>.fromMap(response.data, Folder.fromMap);
    } on DioException catch (e) {
      throw NetworkException(
        statusCode: e.response?.statusCode,
        message: BaseResponse.fromMap(e.response?.data, null).message,
      );
    }
  }

  static Future<BaseResponse<Folder, Object>> updateFolder(UpdateFolderDto data) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      String? accessToken = sharedPreferences.getString("access_token");

      final response = await api.put(
        "/topic/folder",
        data: data.toMap(),
        options: Options(
          headers: {
            "Authorization": "Bearer $accessToken",
          },
        ),
      );

      return BaseResponse<Folder, Object>.fromMap(response.data, Folder.fromMap);
    } on DioException catch (e) {
      throw NetworkException(
        statusCode: e.response?.statusCode,
        message: BaseResponse.fromMap(e.response?.data, null).message,
      );
    }
  }
}
