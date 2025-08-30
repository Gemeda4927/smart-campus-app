// data/repositories/university_repository_impl.dart
import 'package:mobile/features/university/data/service/university_service.dart';

import '../../domain/entities/university.dart';
import '../../domain/repositories/university_repository.dart';
import '../models/university_model.dart';

class UniversityRepositoryImpl implements UniversityRepository {
  final UniversityService service;

  UniversityRepositoryImpl({required this.service});

  @override
  Future<List<University>> getAllUniversities({
    bool featuredOnly = false,
  }) async {
    try {
      // Fetch from service
      final List<UniversityModel> models = await service.getAllUniversities(
        featuredOnly: featuredOnly,
      );

      // Convert to Entity
      return models
          .map(
            (model) => University(
              id: model.id,
              name: model.name,
              location: model.location,
              type: model.type,
              featured: model.featured,
              imageUrl: model.imageUrl,
            ),
          )
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch universities: $e');
    }
  }
}
