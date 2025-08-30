
import 'package:equatable/equatable.dart';

import '../../domain/entities/user_entity.dart';

abstract class LoginAuthState extends Equatable {
  const LoginAuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends LoginAuthState {}

class AuthLoading extends LoginAuthState {}

class AuthSuccess extends LoginAuthState {
  final UserEntity user;

  const AuthSuccess({required this.user});

  @override
  List<Object?> get props => [user];
}

class AuthFailure extends LoginAuthState {
  final String message;

  const AuthFailure({required this.message});

  @override
  List<Object?> get props => [message];
}

class AuthTokenExists extends LoginAuthState {
  final String token;

  const AuthTokenExists({required this.token});

  @override
  List<Object?> get props => [token];
}
