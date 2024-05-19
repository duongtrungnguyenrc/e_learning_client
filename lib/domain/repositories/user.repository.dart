import 'package:dio/dio.dart';
import 'package:lexa/data/dtos/create_forgot_password_transaction_response.dto.dart';
import 'package:lexa/data/dtos/destroy_forgot_password.dto.dart';
import 'package:lexa/data/dtos/reset_passord.dto.dart';
import 'package:lexa/data/dtos/sign_up_request.dto.dart';
import 'package:lexa/data/dtos/update_profile.dto.dart';
import 'package:lexa/data/models/user.model.dart';
import 'package:lexa/domain/api/api.dart';
import 'package:lexa/data/dtos/base_response.dto.dart';
import 'package:lexa/data/models/profile.model.dart';
import 'package:lexa/data/models/topic.model.dart';
import 'package:lexa/core/exceptions/network.exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {
  static Future<BaseResponse<User, Object>> signUp(
    SignUpRequestDto payload,
  ) async {
    final response = await api.post("/user/sign-up", data: payload.toMap());
    return BaseResponse<User, Object>.fromMap(
      response.data,
      User.fromMap,
    );
  }

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

  static Future<BaseResponse<List<User>, User>> findAccounts(
      String? key) async {
    final response =
        await api.get("/user/find-accounts", queryParameters: {"key": key});

    return BaseResponse<List<User>, User>.fromMap(response.data, User.fromMap);
  }

  static Future<
          BaseResponse<CreateForgotPasswordTransactionResponseDto, Object>>
      createForgotPasswordTransaction(String userId) async {
    final response =
        await api.get("/user/forgot-password", data: {"userId": userId});

    return BaseResponse<CreateForgotPasswordTransactionResponseDto,
        Object>.fromMap(
      response.data,
      CreateForgotPasswordTransactionResponseDto.fromMap,
    );
  }

  static Future<BaseResponse<dynamic, Object>> destroyForgotPasswordTransaction(
      DestroyForgotPasswordTransactionDto payload) async {
    final response = await api.delete("/user/forgot-password",
        queryParameters: payload.toMap());

    return BaseResponse<dynamic, Object>.fromMap(
      response.data,
      null,
    );
  }

  static Future<BaseResponse<dynamic, dynamic>> resetPassword(
      ResetPasswordDto payload) async {
    final response = await api.post(
      "/user/reset-password",
      data: payload.toMap(),
    );

    return BaseResponse<dynamic, dynamic>.fromMap(
      response.data,
      null,
    );
  }

  static Future<BaseResponse<User, dynamic>> updateProfile(
      UpdateProfileDto payload) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    String? accessToken = sharedPreferences.getString("access_token");

    final response = await api.put(
      "/user/profile",
      data: payload.toMap(),
      options: Options(
        headers: {
          "Authorization": "Bearer $accessToken",
        },
      ),
    );

    return BaseResponse<User, dynamic>.fromMap(
      response.data,
      User.fromMap,
    );
  }
}
