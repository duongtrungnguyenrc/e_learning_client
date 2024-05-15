import 'package:dio/dio.dart';

final options = BaseOptions(
  baseUrl: 'http://localhost:3000',
  connectTimeout: const Duration(seconds: 5),
  receiveTimeout: const Duration(seconds: 3),
);

final dioNetwork = Dio(options);
