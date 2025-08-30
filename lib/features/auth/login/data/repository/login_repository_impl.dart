import 'package:mobile/core/handlers/dio_client.dart';
import 'package:mobile/features/auth/login/data/services/login_services.dart';
import 'package:mobile/features/auth/login/domain/repository/login_repository.dart';

import '../../domain/entities/user_entity.dart';

class LoginRepositoryImpl implements LoginAuthRepository {
  final LoginAuthService loginAuthService;

  LoginRepositoryImpl(this.loginAuthService);

  @override
  Future<UserEntity> login(String email, String password) async {
    final user = await loginAuthService.login(email, password);
    return user;
  }

  @override
  Future<void> logout() async {
    await DioClient.clearToken();
  }

  @override
  Future<String?> getToken() async {
    return await DioClient.getToken();
  }
}
