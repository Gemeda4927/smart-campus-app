import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class DioClient {
  static final DioClient _instance = DioClient._internal();
  factory DioClient() => _instance;

  late final Dio dio;
  final Logger logger = Logger();

  DioClient._internal() {
    final options = BaseOptions(
      baseUrl: "http://192.168.1.2:3000/api/v1",
      contentType: "application/json",
      responseType: ResponseType.json,
    );

    dio = Dio(options);

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          if (kDebugMode) {
            logger.i('''
              ➡️ REQUEST[${options.method}] => PATH: ${options.uri}
              Headers: ${options.headers}
              Query Parameters: ${options.queryParameters}
              Request Data: ${options.data}
              ''');
          }
          return handler.next(options);
        },
        onResponse: (response, handler) {
          if (kDebugMode) {
            logger.i('''
          ✅ RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.uri}
             Response Data: ${response.data}
          ''');
          }
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          logger.e('''
            ❌ ERROR[${e.response?.statusCode}] => PATH: ${e.requestOptions.uri}
            Error: ${e.error}
            Message: ${e.message}
            Response Data: ${e.response?.data}
            Request Headers: ${e.requestOptions.headers}
            Request Data: ${e.requestOptions.data}
            ''');

          if (e.response?.statusCode == 400) {
            logger.e("Bad Request Details: ${e.response?.data}");
          }

          return handler.next(e);
        },
      ),
    );
  }

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

  Future<Response> post(String path, {dynamic data}) async {
    try {
      if (kDebugMode) {
        logger.i("POST Request Data: $data");
      }
      return await dio.post(path, data: data);
    } catch (e) {
      logger.e("POST Request Failed: $e");
      rethrow;
    }
  }
}