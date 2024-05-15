import 'package:dio/dio.dart';
import 'package:lexa/data/models/user.model.dart';
import 'package:lexa/domain/api/api.dart';
import 'package:lexa/data/dtos/base_response.dto.dart';
import 'package:lexa/data/models/profile.model.dart';
import 'package:lexa/data/models/topic.model.dart';
import 'package:lexa/core/exceptions/network.exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {
  static Future<BaseResponse<List<Topic>, Topic>>
      loadAuthenticatedProfileTopics() async {
    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      String? accessToken = sharedPreferences.getString("access_token");

      final response = await api.get(
        "/topic",
        options: Options(
          headers: {
            "Authorization": "Bearer $accessToken",
          },
        ),
      );

      return BaseResponse<List<Topic>, Topic>.fromMap(
          response.data, Topic.fromMap);
    } on DioException catch (e) {
      throw NetworkException(
        statusCode: e.response?.statusCode,
        message: BaseResponse.fromMap(e.response?.data, null).message,
      );
    }
  }

  static Future<BaseResponse<Profile, Object>> loadProfile(String? id) async {
    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      String? accessToken = sharedPreferences.getString("access_token");

      Map<String, dynamic> queryParams = {
        if (id != null) 'id': id,
      };

      final response = await api.get(
        "/user/profile",
        queryParameters: queryParams,
        options: Options(
          headers: {
            "Authorization": "Bearer $accessToken",
          },
        ),
      );

      return BaseResponse<Profile, Object>.fromMap(
          response.data, Profile.fromMap);
    } on DioException catch (e) {
      throw NetworkException(
        statusCode: e.response?.statusCode,
        message: BaseResponse.fromMap(e.response?.data, null).message,
      );
    }
  }

  static Future<BaseResponse<List<User>, User>> loadTopAuthors() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    String? accessToken = sharedPreferences.getString("access_token");

    final response = await api.get(
      "/user/top-author",
      options: Options(
        headers: {
          "Authorization": "Bearer $accessToken",
        },
      ),
    );

    return BaseResponse<List<User>, User>.fromMap(response.data, User.fromMap);
  }
}
