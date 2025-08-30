// presentation/bloc/university_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_all_universities.dart';
import '../../domain/usecases/get_featured_universities.dart';
import 'university_event.dart';
import 'university_state.dart';

class UniversityBloc extends Bloc<UniversityEvent, UniversityState> {
  final GetAllUniversitiesUseCase getAllUniversities;
  final GetFeaturedUniversitiesUseCase getFeaturedUniversities;

  UniversityBloc({
    required this.getAllUniversities,
    required this.getFeaturedUniversities,
  }) : super(UniversityInitial()) {
    on<LoadFeaturedUniversities>((event, emit) async {
      await _loadUniversities(emit, fetchFeatured: true);
    });

    on<LoadAllUniversities>((event, emit) async {
      await _loadUniversities(emit);
    });
  }

  Future<void> _loadUniversities(
    Emitter<UniversityState> emit, {
    bool fetchFeatured = false,
  }) async {
    emit(UniversityLoading());
    try {
      final universities = fetchFeatured
          ? await getFeaturedUniversities()
          : await getAllUniversities();
      emit(UniversityLoaded(universities));
    } catch (e) {
      emit(UniversityError(e.toString()));
    }
  }
}
