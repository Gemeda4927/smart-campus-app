import 'package:bloc/bloc.dart';
import 'package:mobile/features/auth/signup/domain/entities/user.dart';
import 'package:mobile/features/auth/signup/domain/usecases/signup_user.dart';
import 'package:mobile/features/auth/signup/presentation/bloc/signup_event.dart';
import 'package:mobile/features/auth/signup/presentation/bloc/signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final SignupUser signupUser;

  SignupBloc({required this.signupUser}) : super(SignupInitial()) {
    on<SignupButtonPressed>(_onSignupButtonPressed);
  }

  Future<void> _onSignupButtonPressed(
    SignupButtonPressed event,
    Emitter<SignupState> emit,
  ) async {
    emit(SignupLoading());
    try {
      final user = await _signup(
        name: event.name,
        email: event.email,
        password: event.password,
        passwordConfirm: event.passwordConfirm,
        role: event.role,
        campus: event.campus,
        department: event.department,
      );
      emit(SignupSuccess(user));
    } catch (e) {
      emit(SignupFailure(e.toString()));
    }
  }

  Future<User> _signup({
    required String name,
    required String email,
    required String password,
    required String passwordConfirm,
    String? role,
    String? campus,
    String? department,
  }) async {
    return await signupUser(
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
