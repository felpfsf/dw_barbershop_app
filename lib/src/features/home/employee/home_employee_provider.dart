import 'package:dw_barbershop/src/core/fp/either.dart';
import 'package:dw_barbershop/src/core/providers/application_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_employee_provider.g.dart';

@riverpod
Future<int> getTotalSchedulesToday(
    GetTotalSchedulesTodayRef ref, int userId) async {
  
  // await Future.delayed(const Duration(seconds: 4));

  final DateTime(:year, :month, :day) = DateTime.now();
  final filter = (
    date: DateTime(year, month, day, 0, 0, 0),
    userId: userId,
  );

  final scheduleRepository = ref.read(scheduleRepositoryProvider);

  final response = await scheduleRepository.findScheduleByDate(filter);

  return switch (response) {
    Right(value: List(length: final totalSchedules)) => totalSchedules,
    Left(value: final exception) => throw exception
  };
}
