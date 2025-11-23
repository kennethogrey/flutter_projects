part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthError extends AuthState {
  final String error;

  AuthError(this.error);
}

final class AuthLoggedIn extends AuthState {
  final User user;
  AuthLoggedIn({required this.user});
}

final class AuthSignUpSuccess extends AuthState {}
