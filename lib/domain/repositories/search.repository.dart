import 'package:dio/dio.dart';
import 'package:lexa/core/exceptions/network.exception.dart';
import 'package:lexa/data/dtos/base_response.dto.dart';
import 'package:lexa/data/dtos/search_result.dto.dart';
import 'package:lexa/domain/api/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchRepository {
  static Future<BaseResponse<SearchResultDto, Object>> searchByKey(
      String keyword, int? limit) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    try {
      String? accessToken = sharedPreferences.getString("access_token");

      Map<String, dynamic> queryParams = {
        "key": keyword,
      };

      final response = await api.get(
        "/search",
        queryParameters: queryParams,
        options: Options(
          headers: {
            "Authorization": "Bearer $accessToken",
          },
        ),
      );
      return BaseResponse<SearchResultDto, Object>.fromMap(
          response.data, SearchResultDto.fromMap);
    } on DioException catch (e) {
      throw NetworkException(
        statusCode: e.response?.statusCode,
        message: BaseResponse.fromMap(e.response?.data, null).message,
      );
    }
  }
}
