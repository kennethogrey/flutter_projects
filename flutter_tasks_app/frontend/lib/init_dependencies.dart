import 'package:frontend/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:frontend/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:frontend/features/auth/domain/repositories/auth_repository.dart';
import 'package:frontend/features/auth/domain/usecases/log_user_in.dart';
import 'package:frontend/features/auth/domain/usecases/sign_user_up.dart';
import 'package:frontend/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> initDependencies() async {
  sl.registerFactory<http.Client>(() => http.Client());

  _initAuth();
}

void _initAuth() {
  //datasources
  sl.registerFactory<AuthRemoteDatasource>(
    () => AuthRemoteDatasourceImpl(client: sl()),
  );
  //repository
  sl.registerFactory<AuthRepository>(() => AuthRepositoryImpl(sl()));
  //usecases
  sl.registerFactory(() => SignUserUp(sl()));
  sl.registerFactory(() => LogUserIn(sl()));
  //bloc
  sl.registerLazySingleton(() => AuthBloc(signUpUser: sl(), logUserIn: sl()));
}
