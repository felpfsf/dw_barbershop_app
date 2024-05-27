import 'package:dw_barbershop/src/core/exceptions/repository_exception.dart';
import 'package:dw_barbershop/src/core/fp/either.dart';
import 'package:dw_barbershop/src/core/providers/application_providers.dart';
import 'package:dw_barbershop/src/models/schedule_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'employee_schedule_vm.g.dart';

@riverpod
class EmployeeScheduleVm extends _$EmployeeScheduleVm {
  Future<Either<RepositoryException, List<ScheduleModel>>> _getSchedules(
      int userId, DateTime date) {
    final repository = ref.read(scheduleRepositoryProvider);

    return repository.findScheduleByDate((userId: userId, date: date));
  }

  @override
  Future<List<ScheduleModel>> build(int userId, DateTime date) async {
    final scheduleList = await _getSchedules(userId, date);

    return switch (scheduleList) {
      Right(value: final schedules) => schedules,
      Left() => throw Exception('Erro ao buscar agendamentos'),
    };
  }

  Future<void> changeDate(int userId, DateTime date) async {
    final scheduleList = await _getSchedules(userId, date);

    state = switch (scheduleList) {
      Right(value: final schedules) => AsyncData(schedules),
      Left(value: final exception) =>
        AsyncError(Exception(exception), StackTrace.current),
    };
  }
}
