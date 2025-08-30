import 'package:mobile/features/auth/login/domain/entities/user_entity.dart';
import 'package:mobile/features/auth/login/domain/repository/login_repository.dart';

abstract class UseCase<Type, Params> {
  Future<Type> call(Params params);
}

/// -------------------- LOGIN USE CASE --------------------
class LoginParams {
  final String email;
  final String password;

  LoginParams({required this.email, required this.password});
}

class LoginUseCase implements UseCase<UserEntity, LoginParams> {
  final LoginAuthRepository loginAuthRepository;

  LoginUseCase(this.loginAuthRepository);

  @override
  Future<UserEntity> call(LoginParams params) async {
    return await loginAuthRepository.login(params.email, params.password);
  }
}

/// -------------------- LOGOUT USE CASE --------------------
class LogoutUseCase implements UseCase<void, void> {
  final LoginAuthRepository loginAuthRepository;

  LogoutUseCase(this.loginAuthRepository);

  @override
  Future<void> call(void params) async {
    await loginAuthRepository.logout();
  }
}

/// -------------------- GET TOKEN USE CASE --------------------
class GetTokenUseCase implements UseCase<String?, void> {
  final LoginAuthRepository loginAuthRepository;

  GetTokenUseCase(this.loginAuthRepository);

  @override
  Future<String?> call(void params) async {
    return await loginAuthRepository.getToken();
  }
}
