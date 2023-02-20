import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dw9_delivery_app/app/core/exceptions/repository_exception.dart';
import 'package:dw9_delivery_app/app/core/exceptions/unauthorized_exception.dart';
import 'package:dw9_delivery_app/app/core/rest_client/custom_dio.dart';
import 'package:dw9_delivery_app/app/models/auth_model.dart';
import 'package:dw9_delivery_app/app/repositories/auth/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final CustomDio dio;

  AuthRepositoryImpl({required this.dio});

  @override
  Future<AuthModel> login(String email, String password) async {
    try {
      final result = await dio.unauth().post('/auth', data: {'email': email, 'password': password});
      return AuthModel.fromMap(result.data);
    } on DioError catch (err, stackErr) {
      // * email/senha errada
      if (err.response?.statusCode == 403) {
        log("Premissão negada", error: err, stackTrace: stackErr);
        throw UnauthorizedException();
      }

      log("erro ao realizar Login", error: err, stackTrace: stackErr);
      throw new RepositoryException(message: "erro ao realizar login");
    }
  }

  @override
  Future<void> register(String name, String email, String password) async {
    try {
      await dio.unauth().post(
        "/users",
        data: {'name': name, 'email': email, 'password': password},
      );
    } on DioError catch (err, stackErr) {
      log('erro ao registrar o usuário', error: err, stackTrace: stackErr);
      throw RepositoryException(message: "erro ao registrar o usuário");
    }
  }
}
