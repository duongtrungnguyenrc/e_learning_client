import 'package:dio/dio.dart';
import 'package:lexa/domain/api/api.dart';
import 'package:lexa/core/exceptions/network.exception.dart';
import 'package:lexa/data/dtos/login_response.dto.dart';
import 'package:lexa/data/dtos/register_request.dto.dart';
import 'package:lexa/data/dtos/register_response.dto.dart';
import 'package:lexa/data/dtos/base_response.dto.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  static Future<BaseResponse<LoginResponseDto, Object>> auth(
      String email, String password) async {
    final response = await api.post("/auth/auth", data: {
      "email": email,
      "password": password,
    });

    return BaseResponse<LoginResponseDto, Object>.fromMap(
      response.data,
      LoginResponseDto.fromMap,
    );
  }

  static Future<BaseResponse<LoginResponseDto, Object>> tokenAuth() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    try {
      String? accessToken = sharedPreferences.getString("access_token");
      String? refreshToken = sharedPreferences.getString("refresh_token");

      final response = await api.post(
        "/auth/token-auth",
        data: {"refreshToken": refreshToken},
        options: Options(
          headers: {
            "Authorization": "Bearer $accessToken",
          },
        ),
      );

      return BaseResponse<LoginResponseDto, Object>.fromMap(
          response.data, LoginResponseDto.fromMap);
    } on DioException catch (e) {
      throw NetworkException(
        statusCode: e.response?.statusCode,
        message:
            BaseResponse.fromMap(e.response?.data, null).message.toString(),
      );
    }
  }

  static Future<String> getGoogleLoginUrl() async {
    try {
      final response = await api.get("/auth/google-auth");
      return response.data;
    } on DioException catch (e) {
      throw NetworkException(
        statusCode: e.response?.statusCode,
        message:
            BaseResponse.fromMap(e.response?.data, null).message.toString(),
      );
    }
  }

  static Future<BaseResponse<RegisterResponseDto, Object>> register(
      RegisterRequestDto request) async {
    try {
      final response = await api.post("user/register", data: request);
      return BaseResponse<RegisterResponseDto, Object>.fromMap(
        response.data,
        RegisterResponseDto.fromMap,
      );
    } on DioException catch (e) {
      throw NetworkException(
        statusCode: e.response?.statusCode,
        message:
            BaseResponse.fromMap(e.response?.data, null).message.toString(),
      );
    }
  }
}
