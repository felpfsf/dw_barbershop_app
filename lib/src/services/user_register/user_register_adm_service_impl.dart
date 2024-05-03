import 'package:dw_barbershop/src/core/exceptions/service_exception.dart';
import 'package:dw_barbershop/src/core/fp/either.dart';
import 'package:dw_barbershop/src/core/fp/nil.dart';
import 'package:dw_barbershop/src/repositories/user/user_repository.dart';
import 'package:dw_barbershop/src/services/user/user_login_service.dart';

import 'user_register_adm_service.dart';

class UserRegisterAdmServiceImpl implements UserRegisterAdmService {
  UserRegisterAdmServiceImpl({
    required this.userRepository,
    required this.userLoginService,
  });

  final UserRepository userRepository;
  final UserLoginService userLoginService;

  @override
  Future<Either<ServiceException, Nil>> execute(
      ({String email, String name, String password}) userDTO) async {
    final response = await userRepository.registerAdmin(userDTO);

    switch (response) {
      case Right():
        return userLoginService.execute(userDTO.email, userDTO.password);
      case Left():
        return Left(ServiceException(message: 'Erro ao registrar'));
    }
  }
}
