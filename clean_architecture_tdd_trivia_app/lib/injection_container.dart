import 'package:clean_architecture_tdd_trivia_app/core/network/network_info.dart';
import 'package:clean_architecture_tdd_trivia_app/core/utils/input_converter.dart';
import 'package:clean_architecture_tdd_trivia_app/features/number_trivia/data/datasources/number_trivia_local_datasource.dart';
import 'package:clean_architecture_tdd_trivia_app/features/number_trivia/data/datasources/number_trivia_remote_datasource.dart';
import 'package:clean_architecture_tdd_trivia_app/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:clean_architecture_tdd_trivia_app/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:clean_architecture_tdd_trivia_app/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:clean_architecture_tdd_trivia_app/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:clean_architecture_tdd_trivia_app/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  //!features
  //bloc
  sl.registerFactory(
    () => NumberTriviaBloc(
      getConcreteNumberTrivia: sl(),
      getRandomNumberTrivia: sl(),
      inputConverter: sl(),
    ),
  );
  //usecases
  sl.registerLazySingleton(() => GetConcreteNumberTrivia(sl()));
  sl.registerLazySingleton(() => GetRandomNumberTrivia(sl()));

  //repository
  sl.registerLazySingleton<NumberTriviaRepository>(
    () => NumberTriviaRepositoryImpl(
      remoteDatasource: sl(),
      localDatasource: sl(),
      networkInfo: sl(),
    ),
  );

  // Datasources
  sl.registerLazySingleton<NumberTriviaRemoteDatasource>(
    () => NumberTriviaRemoteDatasourceImpl(client: sl()),
  );
  sl.registerLazySingleton<NumberTriviaLocalDatasource>(
    () => NumberTriviaLocalDatasourceImpl(sharedPreferences: sl()),
  );

  //!Core
  sl.registerLazySingleton(() => InputConverter());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImp(sl()));

  //!External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnection());
}
