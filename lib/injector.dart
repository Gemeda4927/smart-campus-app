import 'package:get_it/get_it.dart';
import 'package:mobile/core/handlers/dio_client.dart';
import 'package:mobile/features/auth/login/data/repository/login_repository_impl.dart';
import 'package:mobile/features/auth/login/data/services/login_services.dart';
import 'package:mobile/features/auth/login/domain/repository/login_repository.dart';
import 'package:mobile/features/auth/login/domain/usecases/login_usecases.dart';
import 'package:mobile/features/auth/login/presentation/bloc/login_bloc.dart';
import 'package:mobile/features/auth/signup/data/repository/signup_repository_impl.dart';
import 'package:mobile/features/auth/signup/data/services/services.dart';
import 'package:mobile/features/auth/signup/domain/repository/signup_repository.dart';
import 'package:mobile/features/auth/signup/domain/usecases/signup_user.dart';
import 'package:mobile/features/auth/signup/presentation/bloc/signup_bloc.dart';
import 'package:mobile/features/university/data/repository/university_repository_impl.dart';
import 'package:mobile/features/university/data/service/university_service.dart';
import 'package:mobile/features/university/domain/repositories/university_repository.dart';
import 'package:mobile/features/university/domain/usecases/get_all_universities.dart';
import 'package:mobile/features/university/domain/usecases/get_featured_universities.dart';
import 'package:mobile/features/university/presentation/bloc/university_bloc.dart';

final sl = GetIt.instance;

Future<void> initInjector() async {
  // ------------------ Core Services ------------------
  sl.registerSingleton<DioClient>(DioClient(baseUrl: 'http://localhost:5000'));

  // ------------------ Feature: Sign Up ------------------
  sl.registerSingleton<SignupServices>(
    SignupServices(dioClient: sl<DioClient>()),
  );
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(signupServices: sl<SignupServices>()),
  );
  sl.registerLazySingleton<SignupUser>(() => SignupUser(sl<AuthRepository>()));
  sl.registerFactory<SignupBloc>(
    () => SignupBloc(signupUser: sl<SignupUser>()),
  );

  // ------------------ Feature: Login / Auth ------------------
  sl.registerSingleton<LoginAuthService>(LoginAuthService(sl<DioClient>()));
  sl.registerLazySingleton<LoginAuthRepository>(
    () => LoginRepositoryImpl(sl<LoginAuthService>()),
  );

  sl.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(sl<LoginAuthRepository>()),
  );
  sl.registerLazySingleton<LogoutUseCase>(
    () => LogoutUseCase(sl<LoginAuthRepository>()),
  );
  sl.registerLazySingleton<GetTokenUseCase>(
    () => GetTokenUseCase(sl<LoginAuthRepository>()),
  );
  sl.registerFactory<LoginAuthBloc>(
    () => LoginAuthBloc(
      loginUseCase: sl<LoginUseCase>(),
      logoutUseCase: sl<LogoutUseCase>(),
      getTokenUseCase: sl<GetTokenUseCase>(),
    ),
  );

  sl.registerSingleton<UniversityService>(
    UniversityService(dioClient: sl<DioClient>()),
  );

  sl.registerLazySingleton<UniversityRepository>(
    () => UniversityRepositoryImpl(service: sl<UniversityService>()),
  );

  sl.registerLazySingleton<GetAllUniversitiesUseCase>(
    () => GetAllUniversitiesUseCase(sl<UniversityRepository>()),
  );

  sl.registerLazySingleton<GetFeaturedUniversitiesUseCase>(
    () => GetFeaturedUniversitiesUseCase(sl<UniversityRepository>()),
  );

  sl.registerFactory<UniversityBloc>(
    () => UniversityBloc(
      getAllUniversities: sl<GetAllUniversitiesUseCase>(),
      getFeaturedUniversities: sl<GetFeaturedUniversitiesUseCase>(),
    ),
  );
}
