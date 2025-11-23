import 'dart:convert';

import 'package:frontend/core/constants/constants.dart';
import 'package:frontend/core/errors/exceptions.dart';
import 'package:frontend/features/auth/data/models/user_model.dart';
import 'package:http/http.dart' as http;

abstract interface class AuthRemoteDatasource {
  Future<UserModel> signUp({
    required String name,
    required String email,
    required String password,
  });
  Future<UserModel> login({required String email, required String password});
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final http.Client client;
  AuthRemoteDatasourceImpl({http.Client? client})
    : client = client ?? http.Client();
  @override
  Future<UserModel> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final res = await client.post(
        Uri.parse('${Constants.backendUri}/auth/signup'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'name': name, 'email': email, 'password': password}),
      );

      if (res.statusCode != 201) {
        throw jsonDecode(res.body)['error'];
      }
      return UserModel.fromJson(jsonDecode(res.body));
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final res = await client.post(
        Uri.parse('${Constants.backendUri}/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (res.statusCode != 200) {
        throw jsonDecode(res.body)['error'];
      }
      return UserModel.fromJson(jsonDecode(res.body));
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
