import 'package:dw_barbershop/src/core/constants/local_storage_constants.dart';
import 'package:dw_barbershop/src/core/providers/application_providers.dart';
import 'package:dw_barbershop/src/models/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'splash_vm.g.dart';

enum SplashState {
  initial,
  login,
  loggedAdm,
  loggedEmployee,
  error,
}

@riverpod
class SplashVm extends _$SplashVm {
  @override
  Future<SplashState> build() async {
    final sp = await SharedPreferences.getInstance();

    if (sp.containsKey(LocalStorageConstants.accessToken)) {
      ref.invalidate(getMeProvider);
      ref.invalidate(getMyBarbershopProvider);

      try {
        final userModel = await ref.watch(getMeProvider.future);

        return switch (userModel) {
          UserModelADM() => SplashState.loggedAdm,
          UserModelEmployee() => SplashState.loggedEmployee,
          // TODO: Handle this case.
          UserModel() => throw UnimplementedError(),
        };
      } catch (e) {
        return SplashState.login;
      }
    }

    return SplashState.login;
  }
}
