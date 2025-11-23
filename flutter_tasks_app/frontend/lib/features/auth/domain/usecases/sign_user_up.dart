import 'package:fpdart/fpdart.dart';
import 'package:frontend/core/errors/failure.dart';
import 'package:frontend/core/usecases/usecase.dart';
import 'package:frontend/features/auth/domain/entities/user.dart';
import 'package:frontend/features/auth/domain/repositories/auth_repository.dart';

class SignUserUp implements Usecase<User, UserSignUpParams> {
  final AuthRepository authRepository;

  SignUserUp(this.authRepository);
  @override
  Future<Either<Failure, User>> call(UserSignUpParams params) async {
    return await authRepository.signUp(
      name: params.name,
      email: params.email,
      password: params.password,
    );
  }
}

class UserSignUpParams {
  final String name;
  final String password;
  final String email;

  UserSignUpParams({
    required this.name,
    required this.password,
    required this.email,
  });
}
