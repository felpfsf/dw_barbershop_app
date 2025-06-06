import 'package:asyncstate/asyncstate.dart';
import 'package:dw_barbershop/src/core/exceptions/repository_exception.dart';
import 'package:dw_barbershop/src/core/fp/either.dart';
import 'package:dw_barbershop/src/core/fp/nil.dart';
import 'package:dw_barbershop/src/core/providers/application_providers.dart';
import 'package:dw_barbershop/src/features/employee/register/employee_register_state.dart';
import 'package:dw_barbershop/src/models/barbershop_model.dart';
import 'package:dw_barbershop/src/repositories/user/user_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'employee_register_vm.g.dart';

@riverpod
class EmployeeRegisterVm extends _$EmployeeRegisterVm {
  @override
  EmployeeRegisterState build() => EmployeeRegisterState.initial();

  void setRegisterAdm(bool isRegisterAdm) {
    state = state.copyWith(registerAdm: isRegisterAdm);
  }

  void addOrRemoveWorkDay(String weekday) {
    final EmployeeRegisterState(:workDays) = state;

    if (workDays.contains(weekday)) {
      workDays.remove(weekday);
    } else {
      workDays.add(weekday);
    }

    state = state.copyWith(workDays: workDays);
  }

  void addOrRemoveWorkhour(int hour) {
    final EmployeeRegisterState(:workHours) = state;

    if (workHours.contains(hour)) {
      workHours.remove(hour);
    } else {
      workHours.add(hour);
    }

    state = state.copyWith(workHours: workHours);
  }

  Future<void> register(String? name, String? email, String? password) async {
    final EmployeeRegisterState(:registerAdm, :workDays, :workHours) = state;
    final asyncLoaderHandler = AsyncLoaderHandler()..start();

    final UserRepository(:registerAdmAsEmployee, :registerEmployee) =
        ref.read(userRepositoryProvider);

    final Either<RepositoryException, Nil> resultRegister;

    if (registerAdm) {
      final dto = (
        workDays: workDays,
        workHours: workHours,
      );

      resultRegister = await registerAdmAsEmployee(dto);
    } else {
      final BarbershopModel(:id) =
          await ref.watch(getMyBarbershopProvider.future);
      final dto = (
        barbershopId: id,
        name: name!,
        email: email!,
        password: password!,
        workDays: workDays,
        workHours: workHours,
      );

      resultRegister = await registerEmployee(dto);
    }

    switch (resultRegister) {
      case Right():
        state = state.copyWith(status: EmployeeRegisterStateStatus.success);
        break;
      case Left():
        state = state.copyWith(status: EmployeeRegisterStateStatus.error);
        break;
    }
    asyncLoaderHandler.close();
  }
}
