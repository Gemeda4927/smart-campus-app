import 'package:mobile/core/handlers/dio_client.dart';
import 'package:mobile/features/auth/signup/data/models/user_model.dart';

class SignupServices {
  final DioClient dioClient;

  SignupServices({required this.dioClient});

  Future<UserModel> signup({
    required String name,
    required String email,
    required String password,
    required String passwordConfirm,
    String? role,
    String? campus,
    String? department,
  }) async {
    final response = await dioClient.post(
      '/api/v1/users/signup',
      data: {
        'name': name,
        'email': email,
        'password': password,
        'passwordConfirm': passwordConfirm,
        'role': role ?? 'user',
        'campus': campus,
        'department': department,
      },
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      return UserModel.fromJson(response.data['data']['user']);
    } else {
      throw Exception('Signup failed: ${response.data}');
    }
  }
}
