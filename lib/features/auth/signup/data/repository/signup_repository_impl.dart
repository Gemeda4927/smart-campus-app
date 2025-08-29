import 'package:mobile/features/auth/signup/domain/entities/user.dart';
import 'package:mobile/features/auth/signup/data/services/services.dart';
import 'package:mobile/features/auth/signup/domain/repository/signup_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final SignupServices signupServices;

  AuthRepositoryImpl({required this.signupServices});

  @override
  Future<User> signup({
    required String name,
    required String email,
    required String password,
    required String passwordConfirm,
    String? role,
    String? campus,
    String? department,
  }) async {
    final userModel = await signupServices.signup(
      name: name,
      email: email,
      password: password,
      passwordConfirm: passwordConfirm,
      role: role,
      campus: campus,
      department: department,
    );

    // Map UserModel to User entity
    return User(
      name: userModel.name,
      email: userModel.email,
      role: userModel.role,
      campus: userModel.campus,
      department: userModel.department,
      id: '',
      subscription: '',
      paymentStatus: '',
      walletBalance: null,
    );
  }
}
