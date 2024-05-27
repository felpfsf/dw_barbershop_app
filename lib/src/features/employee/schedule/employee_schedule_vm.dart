import 'package:dw_barbershop/src/core/fp/either.dart';
import 'package:dw_barbershop/src/core/providers/application_providers.dart';
import 'package:dw_barbershop/src/models/schedule_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'employee_schedule_vm.g.dart';

@riverpod
class EmployeeScheduleVm extends _$EmployeeScheduleVm {
  
  @override
  Future<List<ScheduleModel>> build(int userId, DateTime date) async {
    final repository = ref.read(scheduleRepositoryProvider);

    final response =
        await repository.findScheduleByDate((userId: userId, date: date));

    return switch (response) {
      Right(value: final schedules) => schedules,
      Left() => throw Exception('Erro ao buscar agendamentos'),
    };
  }
}
