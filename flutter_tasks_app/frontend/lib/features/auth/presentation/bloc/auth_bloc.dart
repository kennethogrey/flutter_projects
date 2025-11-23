import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/features/auth/domain/entities/user.dart';
import 'package:frontend/features/auth/domain/usecases/log_user_in.dart';
import 'package:frontend/features/auth/domain/usecases/sign_user_up.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignUserUp _signUserUp;
  final LogUserIn _logUserIn;
  AuthBloc({required SignUserUp signUpUser, required LogUserIn logUserIn})
    : _signUserUp = signUpUser,
      _logUserIn = logUserIn,
      super(AuthInitial()) {
    on<AuthEvent>((_, emit) => emit(AuthLoading()));
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthLogin>(_onAuthLogin);
  }

  void _onAuthSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    final res = await _signUserUp(
      UserSignUpParams(
        name: event.name,
        password: event.password,
        email: event.email,
      ),
    );
    res.fold(
      (failure) => emit(AuthError(failure.error)),
      (user) => emit(AuthSignUpSuccess()),
    );
  }

  void _onAuthLogin(AuthLogin event, Emitter<AuthState> emit) async {
    final res = await _logUserIn(
      UserLoginParams(email: event.email, password: event.password),
    );
    res.fold(
      (failure) => emit(AuthError(failure.error)),
      (user) => emit(AuthLoggedIn(user: user)),
    );
  }
}
