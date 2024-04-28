import 'package:asyncstate/asyncstate.dart';
import 'package:dw_barbershop/src/core/exceptions/service_exception.dart';
import 'package:dw_barbershop/src/core/fp/either.dart';
import 'package:dw_barbershop/src/core/providers/application_providers.dart';
import 'package:dw_barbershop/src/features/auth/login/login_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_vm.g.dart';

@riverpod
class LoginVM extends _$LoginVM {
  @override
  LoginState build() => LoginState.initial();

  Future<void> login(String email, String password) async {
    // Controle manual do asyncstate
    final loaderHandler = AsyncLoaderHandler()..start();

    final loginService = ref.watch(userLoginServiceProvider);

    final response = await loginService.execute(email, password);

    switch (response) {
      case Left(value: ServiceException(:final message)):
        state = state.copyWith(
          status: LoginStateStatus.error,
          error: () => message,
        );
        break;
      case Right():
        // Get user data
        // Check user permissions
    }

    loaderHandler.close();
  }
}
