import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final options = BaseOptions(
  baseUrl: '${dotenv.env['SERVER_HOST']}:${dotenv.env['SERVER_PORT']}/api',
  connectTimeout: const Duration(seconds: 30),
  receiveTimeout: const Duration(seconds: 30),
);

final api = Dio(options);
