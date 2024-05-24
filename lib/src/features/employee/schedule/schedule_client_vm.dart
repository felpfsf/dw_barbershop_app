import 'package:asyncstate/asyncstate.dart';
import 'package:dw_barbershop/src/core/fp/either.dart';
import 'package:dw_barbershop/src/core/providers/application_providers.dart';
import 'package:dw_barbershop/src/features/employee/schedule/schedule_client_state.dart';
import 'package:dw_barbershop/src/models/barbershop_model.dart';
import 'package:dw_barbershop/src/models/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'schedule_client_vm.g.dart';

@riverpod
class ScheduleVm extends _$ScheduleVm {
  @override
  ScheduleState build() => ScheduleState.initial();

  void hourSelected(int hour) {
    if (hour == state.scheduledHour) {
      state = state.copyWith(scheduledHour: () => null);
    } else {
      state = state.copyWith(scheduledHour: () => hour);
    }
  }

  void dateSelected(DateTime date) {
    state = state.copyWith(scheduleDate: () => date);
  }

  Future<void> register(
      {required UserModel userModel, required String client}) async {
    final loaderHandler = AsyncLoaderHandler()..start();

    final ScheduleState(:scheduleDate, :scheduledHour) = state;
    final scheduleRepository = ref.read(scheduleRepositoryProvider);
    final BarbershopModel(id: barbershopId) =
        await ref.watch(getMyBarbershopProvider.future);

    final scheduleDto = (
      barbershopId: barbershopId,
      userId: userModel.id,
      client: client,
      date: scheduleDate!,
      hour: scheduledHour!,
    );

    final response =
        await scheduleRepository.registerScheduleClient(scheduleDto);

    switch (response) {
      case Right():
        state = state.copyWith(status: ScheduleStateStatus.success);
      case Left():
        state = state.copyWith(status: ScheduleStateStatus.error);
    }

    loaderHandler.close();
  }
}
