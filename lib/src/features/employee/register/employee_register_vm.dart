import 'package:dw_barbershop/src/features/employee/register/employee_register_state.dart';
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
}
