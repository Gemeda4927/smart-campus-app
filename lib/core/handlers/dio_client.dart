import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioClient {
  final Dio dio;
  final Logger logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 5,
      lineLength: 80,
      colors: true,
      printEmojis: true,
      printTime: true,
    ),
  );

  static const String _tokenKey = "auth_token";

  DioClient({required String baseUrl})
      : dio = Dio(
          BaseOptions(
            baseUrl: baseUrl,
            contentType: "application/json",
            responseType: ResponseType.json,
          ),
        ) {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Attach token to every request if available
          final token = await DioClient.getToken();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          if (kDebugMode) {
            logger.i(
              '➡️ REQUEST[${options.method}] => PATH: ${options.uri}\n'
              'Headers: ${options.headers}\n'
              'Query: ${options.queryParameters}\n'
              'Data: ${options.data}',
            );
          }

          return handler.next(options);
        },
        onResponse: (response, handler) {
          if (kDebugMode) {
            logger.i(
              '✅ RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.uri}\n'
              'Data: ${response.data}',
            );
          }
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          logger.e(
            '❌ ERROR[${e.response?.statusCode}] => PATH: ${e.requestOptions.uri}\n'
            'Error: ${e.error}\n'
            'Message: ${e.message}\n'
            'Response: ${e.response?.data}\n'
            'Headers: ${e.requestOptions.headers}\n'
            'Request Data: ${e.requestOptions.data}',
          );
          return handler.next(e);
        },
      ),
    );
  }

  /// Save token securely
  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  /// Get stored token
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  /// Clear token on logout
  static Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }

  /// GET request
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await dio.get(path, queryParameters: queryParameters);
    } catch (e) {
      logger.e("GET Request Failed: $e");
      rethrow;
    }
  }

  /// POST request
  Future<Response> post(String path, {dynamic data}) async {
    try {
      if (kDebugMode) logger.i("POST Request Data: $data");
      return await dio.post(path, data: data);
    } catch (e) {
      logger.e("POST Request Failed: $e");
      rethrow;
    }
  }
}
