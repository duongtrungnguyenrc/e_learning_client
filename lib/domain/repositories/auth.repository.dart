import 'package:dio/dio.dart';
import 'package:lexa/domain/api/api.dart';
import 'package:lexa/data/dtos/sign_in_response.dto.dart';
import 'package:lexa/data/dtos/base_response.dto.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  static Future<BaseResponse<SignInResponseDto, Object>> signIn(
      String email, String password) async {
    final response = await api.post("/auth/sign-in", data: {
      "email": email,
      "password": password,
    });

    return BaseResponse<SignInResponseDto, Object>.fromMap(
      response.data,
      SignInResponseDto.fromMap,
    );
  }

  static Future<BaseResponse<String, Object>> signOut() async {
    final response = await api.post("/auth/sign-out");
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();

    return BaseResponse<String, Object>.fromMap(
      response.data,
      null,
    );
  }

  static Future<BaseResponse<SignInResponseDto, Object>> tokenAuth() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

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

    return BaseResponse<SignInResponseDto, Object>.fromMap(
      response.data,
      SignInResponseDto.fromMap,
    );
  }

  static Future<String> getGoogleSignInUrl() async {
    final response = await api.get("/auth/google-auth");
    return response.data;
  }
}
