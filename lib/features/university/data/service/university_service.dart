// data/services/university_service.dart
import 'package:dio/dio.dart';
import 'package:mobile/core/handlers/dio_client.dart';
import '../models/university_model.dart';

class UniversityService {
  final DioClient dioClient;

  UniversityService({required this.dioClient});

  Future<List<UniversityModel>> getAllUniversities({
    bool featuredOnly = false,
  }) async {
    try {
      final query = featuredOnly ? {'featured': true} : null;
      final response = await dioClient.get(
        '/api/v1/universities',
        queryParameters: query,
      );

      if (response.statusCode == 200 && response.data is List) {
        return (response.data as List)
            .map((json) => UniversityModel.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to load universities');
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
