import 'package:dw_barbershop/src/core/fp/either.dart';
import 'package:dw_barbershop/src/core/providers/application_providers.dart';
import 'package:dw_barbershop/src/features/register/user/user_register_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_register_vm.g.dart';

enum UserRegisterStateStatus { initial, success, error }

@riverpod
class UserRegisterVm extends _$UserRegisterVm {
  @override
  UserRegisterStateStatus build() => UserRegisterStateStatus.initial;

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final userDTO = (
      name: name,
      email: email,
      password: password,
    );

    final userRegisterAdmService = ref.watch(userRegisterAdmServiceProvider);
    final response = await userRegisterAdmService.execute(userDTO);

    switch (response) {
      case Right():
        ref.invalidate(getMeProvider);
        state = UserRegisterStateStatus.success;
      case Left():
        state = UserRegisterStateStatus.error;
    }
  }
}
