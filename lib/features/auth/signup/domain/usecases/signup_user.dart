import 'package:mobile/features/auth/signup/domain/entities/user.dart';
import 'package:mobile/features/auth/signup/domain/repository/signup_repository.dart';

class SignupUser {
  final AuthRepository authRepository;

  SignupUser(this.authRepository);

  Future<User> call({
    required String name,
    required String email,
    required String password,
    required String passwordConfirm,
    String? role,
    String? campus,
    String? department,
  }) async {
    return await authRepository.signup(
      name: name,
      email: email,
      password: password,
      passwordConfirm: passwordConfirm,
      role: role,
      campus: campus,
      department: department,
    );
  }
}
