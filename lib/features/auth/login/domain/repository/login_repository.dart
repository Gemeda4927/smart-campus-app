
import 'package:mobile/features/auth/login/domain/entities/user_entity.dart';

abstract class LoginAuthRepository {
  Future<UserEntity> login(String email, String password);
  Future<void> logout();
  Future<String?> getToken();
}
