import 'package:mobile/features/university/domain/entities/university.dart';

abstract class UniversityRepository {
  Future<List<University>> getAllUniversities({bool featuredOnly = false});
}
