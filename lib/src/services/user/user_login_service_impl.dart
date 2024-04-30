import 'package:dw_barbershop/src/core/constants/local_storage_constants.dart';
import 'package:dw_barbershop/src/core/exceptions/auth_exception.dart';
import 'package:dw_barbershop/src/core/exceptions/service_exception.dart';
import 'package:dw_barbershop/src/core/fp/either.dart';
import 'package:dw_barbershop/src/core/fp/nil.dart';
import 'package:dw_barbershop/src/repositories/user/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './user_login_service.dart';

class UserLoginServiceImpl implements UserLoginService {
  final UserRepository userRepository;

  UserLoginServiceImpl({required this.userRepository});
  @override
  Future<Either<ServiceException, Nil>> execute(
      String email, String password) async {
    final response = await userRepository.login(email, password);

    switch (response) {
      case Left(value: AuthError()):
        return Left(ServiceException(message: 'Erro ao realizar login'));

      case Left(value: AuthUnauthorizedException()):
        return Left(ServiceException(message: 'Senha ou usuário inválidos'));

      case Right(value: final accessToken):
        final sp = await SharedPreferences.getInstance();
        sp.setString(LocalStorageConstants.accessToken, accessToken);
        return Right(nil);
    }
  }
}
