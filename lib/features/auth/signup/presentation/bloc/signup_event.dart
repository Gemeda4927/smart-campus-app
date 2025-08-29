abstract class SignupEvent {}

class SignupButtonPressed extends SignupEvent {
  final String name;
  final String email;
  final String password;
  final String passwordConfirm;
  final String? role;
  final String? campus;
  final String? department;

  SignupButtonPressed({
    required this.name,
    required this.email,
    required this.password,
    required this.passwordConfirm,
    this.role,
    this.campus,
    this.department,
  });
}
