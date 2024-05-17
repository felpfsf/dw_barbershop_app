import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dw_barbershop/src/core/exceptions/auth_exception.dart';
import 'package:dw_barbershop/src/core/exceptions/repository_exception.dart';
import 'package:dw_barbershop/src/core/fp/either.dart';
import 'package:dw_barbershop/src/core/fp/nil.dart';
import 'package:dw_barbershop/src/core/restClient/rest_client.dart';
import 'package:dw_barbershop/src/models/user_model.dart';

import './user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final RestClient restClient;

  UserRepositoryImpl({required this.restClient});

  @override
  Future<Either<AuthException, String>> login(
      String email, String password) async {
    try {
      final Response(data: {'access_token': accessToken}) =
          await restClient.unAuth.post(
        '/auth',
        data: {
          'email': email,
          'password': password,
        },
      );

      return Right(accessToken);
    } on DioException catch (e, s) {
      log('❌ Erro ao realizar login', error: e, stackTrace: s);

      return switch (e) {
        DioException(response: Response(statusCode: HttpStatus.forbidden)?) =>
          Left(AuthUnauthorizedException()),
        _ => Left(AuthError(message: '❌ Erro ao realizar login')),
      };
    }
  }

  @override
  Future<Either<RepositoryException, UserModel>> me() async {
    try {
      final Response(:data) = await restClient.auth.get('/me');

      return Right(UserModel.fromMap(data));
    } on DioException catch (e, s) {
      log('Erro ao buscar usuário', error: e, stackTrace: s);
      return Left(
        RepositoryException(message: '❌ Erro ao buscar usuário logado'),
      );
    } on ArgumentError catch (e, s) {
      log('JSON invárlido', error: e, stackTrace: s);
      return Left(
        RepositoryException(message: e.message),
      );
    }
  }

  @override
  Future<Either<RepositoryException, Nil>> registerAdmin(
      ({String email, String name, String password}) userDTO) async {
    try {
      await restClient.unAuth.post('/users', data: {
        'name': userDTO.name,
        'email': userDTO.email,
        'password': userDTO.password,
        'profile': 'ADM',
      });

      return Right(nil);
    } on DioException catch (e, s) {
      log('Erro ao registrar usuário', error: e, stackTrace: s);
      return Left(
        RepositoryException(message: '❌ Erro ao registrar usuário admin'),
      );
    }
  }

  @override
  Future<Either<RepositoryException, List<UserModel>>> getEmployees(
      int barbershopId) async {
    try {
      final Response(:List data) =
          await restClient.auth.get('/users', queryParameters: {
        'barbershop_id': barbershopId,
      });

      final employees =
          data.map((employee) => UserModelEmployee.fromMap(employee)).toList();

      return Right(employees);
    } on DioException catch (e, s) {
      log('Erro ao buscar colaboradores', error: e, stackTrace: s);
      return Left(
        RepositoryException(message: 'Erro ao buscar colaboradores'),
      );
    } on ArgumentError catch (e, s) {
      log('Erro ao converter colaboradores (Invalid JSON)',
          error: e, stackTrace: s);
      return Left(
        RepositoryException(message: 'Erro ao buscar colaboradores'),
      );
    }
  }
}
