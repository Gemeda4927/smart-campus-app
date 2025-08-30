// presentation/bloc/auth/auth_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:mobile/features/auth/login/domain/entities/user_entity.dart';
import 'package:mobile/features/auth/login/domain/usecases/login_usecases.dart';
import 'package:mobile/features/auth/login/presentation/bloc/login_event.dart';
import 'package:mobile/features/auth/login/presentation/bloc/login_state.dart';

class LoginAuthBloc extends Bloc<AuthEvent, LoginAuthState> {
  final LoginUseCase loginUseCase;
  final LogoutUseCase logoutUseCase;
  final GetTokenUseCase getTokenUseCase;

  LoginAuthBloc({
    required this.loginUseCase,
    required this.logoutUseCase,
    required this.getTokenUseCase,
  }) : super(AuthInitial()) {
    on<LoginEvent>(_onLogin);
    on<LogoutEvent>(_onLogout);
    on<CheckTokenEvent>(_onCheckToken);
  }

  Future<void> _onLogin(LoginEvent event, Emitter<LoginAuthState> emit) async {
    emit(AuthLoading());
    try {
      final UserEntity user = await loginUseCase(
        LoginParams(email: event.email, password: event.password),
      );
      emit(AuthSuccess(user: user));
    } catch (e) {
      emit(AuthFailure(message: e.toString()));
    }
  }

  Future<void> _onLogout(LogoutEvent event, Emitter<LoginAuthState> emit) async {
    await logoutUseCase(null);
    emit(AuthInitial());
  }

  Future<void> _onCheckToken(
    CheckTokenEvent event,
    Emitter<LoginAuthState> emit,
  ) async {
    final token = await getTokenUseCase(null);
    if (token != null) {
      emit(AuthTokenExists(token: token));
    } else {
      emit(AuthInitial());
    }
  }
}
