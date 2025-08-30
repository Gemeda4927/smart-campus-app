// domain/usecases/get_all_universities.dart
import '../entities/university.dart';
import '../repositories/university_repository.dart';

class GetAllUniversitiesUseCase {
  final UniversityRepository repository;

  GetAllUniversitiesUseCase(this.repository);

  Future<List<University>> call({bool featuredOnly = false}) async {
    return await repository.getAllUniversities(featuredOnly: featuredOnly);
  }
}
