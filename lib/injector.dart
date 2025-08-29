import 'package:get_it/get_it.dart';
import 'package:mobile/core/handlers/dio_client.dart';
import 'package:mobile/features/auth/signup/data/repository/signup_repository_impl.dart';
import 'package:mobile/features/auth/signup/data/services/services.dart';
import 'package:mobile/features/auth/signup/domain/repository/signup_repository.dart';
import 'package:mobile/features/auth/signup/domain/usecases/signup_user.dart';
import 'package:mobile/features/auth/signup/presentation/bloc/signup_bloc.dart';

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
}
