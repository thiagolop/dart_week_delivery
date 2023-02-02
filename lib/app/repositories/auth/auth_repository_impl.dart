import 'package:dart_week_delivery/app/core/exceptions/unauthorized_exceptions.dart';
import 'package:dart_week_delivery/app/core/rest_client/custom_dio.dart';
import 'package:dart_week_delivery/app/models/auth_model.dart';
import 'package:dio/dio.dart';
import './auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final CustomDio _dio;
  AuthRepositoryImpl({required CustomDio dio}) : _dio = dio;

  @override
  Future<AuthModel> login(String email, String password) async {
    try {
      final result = await _dio.unauth().post('/auth', data: {
        'email': email,
        'password': password,
      });
      return AuthModel.fromMap(result.data);
    } on DioError catch (e) {
      if (e.response?.statusCode == 401) {
        throw UnauthorizedExceptions();
      }
    }
    throw Exception('Erro ao realizar login');
  }

  @override
  Future<void> register(String name, String email, String password) async {
    try {
      await _dio.unauth().post('/users', data: {
        'name': name,
        'email': email,
        'password': password,
      });
    } on DioError catch (e) {
      throw Exception(e.message);
    }
  }
}
