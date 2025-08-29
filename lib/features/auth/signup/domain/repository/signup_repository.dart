import 'package:mobile/features/auth/signup/domain/entities/user.dart';

abstract class AuthRepository {
  Future<User> signup({
    required String name,
    required String email,
    required String password,
    required String passwordConfirm,
    String? role,
    String? campus,
    String? department,
  });
}
