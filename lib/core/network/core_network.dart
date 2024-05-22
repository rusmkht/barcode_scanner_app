import 'package:dio/dio.dart';

Dio createHttpClient(String baseUrl) {
  final dio = Dio();
  dio.options.baseUrl = baseUrl;
  return dio;
}
