import 'dart:convert';

import 'package:clean_architecture_tdd_trivia_app/core/error/exceptions.dart';
import 'package:clean_architecture_tdd_trivia_app/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class NumberTriviaLocalDatasource {
  Future<NumberTriviaModel> getLastNumberTrivia();
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache);
}

const cachedNumberTrivia = 'CACHED_NUMBER_TRIVIA';

class NumberTriviaLocalDatasourceImpl implements NumberTriviaLocalDatasource {
  final SharedPreferences sharedPreferences;

  NumberTriviaLocalDatasourceImpl({required this.sharedPreferences});

  @override
  Future<NumberTriviaModel> getLastNumberTrivia() {
    final jsonString = sharedPreferences.getString(cachedNumberTrivia);
    if (jsonString != null) {
      return Future.value(NumberTriviaModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache) {
    return sharedPreferences.setString(
      cachedNumberTrivia,
      json.encode(triviaToCache.toJson()),
    );
  }
}
