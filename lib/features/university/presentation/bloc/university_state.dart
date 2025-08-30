// presentation/bloc/university_state.dart
import '../../domain/entities/university.dart';

abstract class UniversityState {}

class UniversityInitial extends UniversityState {}

class UniversityLoading extends UniversityState {}

class UniversityLoaded extends UniversityState {
  final List<University> universities;
  UniversityLoaded(this.universities);
}

class UniversityError extends UniversityState {
  final String message;
  UniversityError(this.message);
}

class UniversityLoadedById extends UniversityState {
  final University university;
  UniversityLoadedById(this.university);
}
