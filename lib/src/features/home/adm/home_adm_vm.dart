import 'package:asyncstate/asyncstate.dart';
import 'package:dw_barbershop/src/core/fp/either.dart';
import 'package:dw_barbershop/src/core/providers/application_providers.dart';
import 'package:dw_barbershop/src/features/home/adm/home_adm_state.dart';
import 'package:dw_barbershop/src/models/barbershop_model.dart';
import 'package:dw_barbershop/src/models/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_adm_vm.g.dart';

@riverpod
class HomeAdmVm extends _$HomeAdmVm {
  @override
  Future<HomeAdmState> build() async {
    final repository = ref.read(userRepositoryProvider);
    final BarbershopModel(id: barberShopId) =
        await ref.read(getMyBarbershopProvider.future);

    final me = await ref.watch(getMeProvider.future);

    final response = await repository.getEmployees(barberShopId);

    switch (response) {
      case Right(value: var employeesData):
        final employees = <UserModel>[];

        if (me case UserModelADM(workDays: _?, workHours: _?)) {
          employees.add(me);
        }

        employees.addAll(employeesData);

        return HomeAdmState(
            status: HomeAdmStateStatus.loaded, employees: employees);
      case Left():
        return HomeAdmState(status: HomeAdmStateStatus.error, employees: []);
    }
  }

  Future<void> logout() async => ref.read(logoutProvider.future).asyncLoader();
}
