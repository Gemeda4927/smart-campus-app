// domain/usecases/get_featured_universities.dart
import '../entities/university.dart';
import '../repositories/university_repository.dart';

class GetFeaturedUniversitiesUseCase {
  final UniversityRepository repository;

  GetFeaturedUniversitiesUseCase(this.repository);

  Future<List<University>> call() async {
    return await repository.getAllUniversities(featuredOnly: true);
  }
}
