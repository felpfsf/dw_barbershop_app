import 'package:dw_barbershop/src/core/fp/either.dart';
import 'package:dw_barbershop/src/core/providers/application_providers.dart';
import 'package:dw_barbershop/src/features/register/barbershop/barbershop_register_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'barbershop_register_vm.g.dart';

@riverpod
class BarbershopRegisterVm extends _$BarbershopRegisterVm {
  @override
  BarbershopRegisterState build() => BarbershopRegisterState.initial();

  void addOrRemoveOpeningDay(String weekday) {
    final openingDays = state.openingDays;

    if (openingDays.contains(weekday)) {
      openingDays.remove(weekday);
    } else {
      openingDays.add(weekday);
    }

    state = state.copyWith(openingDays: openingDays);
  }

  void addOrRemoveOpeningHours(int hour) {
    final openingHours = state.openingHours;

    if (openingHours.contains(hour)) {
      openingHours.remove(hour);
    } else {
      openingHours.add(hour);
    }

    state = state.copyWith(openingHours: openingHours);
  }

  Future<void> register(String name, String email) async {
    final repository = ref.watch(barbershopRepositoryProvider);
    final BarbershopRegisterState(:openingDays, :openingHours) = state;

    final barbershopDTO = (
      name: name,
      email: email,
      openingDays: openingDays,
      openingHours: openingHours
    );

    final response = await repository.save(barbershopDTO);

    switch (response) {
      case Right():
        ref.invalidate(getMyBarbershopProvider);
        state = state.copyWith(status: BarbershopRegisterStateStatus.success);
      case Left():
        state = state.copyWith(status: BarbershopRegisterStateStatus.error);
    }
  }
}
