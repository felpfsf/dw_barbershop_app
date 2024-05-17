import 'package:dw_barbershop/src/core/exceptions/auth_exception.dart';
import 'package:dw_barbershop/src/core/exceptions/repository_exception.dart';
import 'package:dw_barbershop/src/core/fp/either.dart';
import 'package:dw_barbershop/src/core/fp/nil.dart';
import 'package:dw_barbershop/src/models/user_model.dart';

abstract interface class UserRepository {
  Future<Either<AuthException, String>> login(String email, String password);

  Future<Either<RepositoryException, UserModel>> me();

  Future<Either<RepositoryException, Nil>> registerAdmin(
    // Esse métdo utilizado é chamado de Record
    // é nomeado os atributos dele depois um nome para a classe
    // Similar aos DTOs
    ({String name, String email, String password}) userDTO,
  );

  Future<Either<RepositoryException, List<UserModel>>> getEmployees(
      int barbershopId);
}
