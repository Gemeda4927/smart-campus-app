import 'package:dio/dio.dart';
import 'package:mobile/core/handlers/dio_client.dart';
import '../model/login_model.dart';


class LoginAuthService {
  final DioClient dioClient;

  LoginAuthService(this.dioClient);

  Future<UserModel> login(String email, String password) async {
    try {
      Response response = await dioClient.post(
        "/api/v1/users/login",
        data: {"email": email, "password": password},
      );

      final data = response.data;

      if (data["status"] == "success") {
        final token = data["token"];
        await DioClient.saveToken(token);

        final user = UserModel.fromJson(data["data"]["user"]);
        return user;
      } else {
        throw Exception("Login failed: ${data["message"] ?? 'Unknown error'}");
      }
    } catch (e) {
      throw Exception("Login error: $e");
    }
  }
}
