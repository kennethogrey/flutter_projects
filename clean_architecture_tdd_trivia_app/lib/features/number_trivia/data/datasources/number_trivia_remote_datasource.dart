import 'dart:convert';

import 'package:clean_architecture_tdd_trivia_app/core/error/exceptions.dart';
import 'package:clean_architecture_tdd_trivia_app/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:http/http.dart' as http;

abstract class NumberTriviaRemoteDatasource {
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number);
  Future<NumberTriviaModel> getRandomNumberTrivia();
}

class NumberTriviaRemoteDatasourceImpl implements NumberTriviaRemoteDatasource {
  final http.Client client;

  NumberTriviaRemoteDatasourceImpl({required this.client});
  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number) async {
    return _getTriviaFromUrl('numbersapi.com', '$number');
  }

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() async {
    return _getTriviaFromUrl('numbersapi.com', 'random');
  }

  Future<NumberTriviaModel> _getTriviaFromUrl(
    String authority,
    String path,
  ) async {
    final response = await client.get(
      Uri.http(authority, path),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return NumberTriviaModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
