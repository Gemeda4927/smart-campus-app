// presentation/bloc/university_event.dart

abstract class UniversityEvent {}

class LoadFeaturedUniversities extends UniversityEvent {}

class LoadAllUniversities extends UniversityEvent {}

class LoadUniversityById extends UniversityEvent {
  final String id;
  LoadUniversityById(this.id);
}
