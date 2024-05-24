import 'dart:developer';

import 'package:dw_barbershop/src/core/ui/barbershop_icons.dart';
import 'package:dw_barbershop/src/core/ui/barbershop_theme.dart';
import 'package:dw_barbershop/src/core/ui/helpers/helper_form.dart';
import 'package:dw_barbershop/src/core/ui/helpers/messages.dart';
import 'package:dw_barbershop/src/core/ui/widgets/barbershop_hours_grid.dart';
import 'package:dw_barbershop/src/core/ui/widgets/barbershop_user_avatar.dart';
import 'package:dw_barbershop/src/features/schedule/schedule_client_state.dart';
import 'package:dw_barbershop/src/features/schedule/schedule_client_vm.dart';
import 'package:dw_barbershop/src/features/home/widgets/schedule_calendar.dart';
import 'package:dw_barbershop/src/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:validatorless/validatorless.dart';

class ScheduleClientPage extends ConsumerStatefulWidget {
  const ScheduleClientPage({super.key});

  @override
  ConsumerState<ScheduleClientPage> createState() => _ScheduleClientPageState();
}

class _ScheduleClientPageState extends ConsumerState<ScheduleClientPage> {
  var dateFormat = DateFormat('dd/MM/yyyy');
  bool showCalendar = false;
  final formKey = GlobalKey<FormState>();
  final clientEC = TextEditingController();
  final dateSelectedEC = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    clientEC.dispose();
    dateSelectedEC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userModel = ModalRoute.of(context)!.settings.arguments as UserModel;
    final scheduleVM = ref.watch(scheduleVmProvider.notifier);

    final employeeData = switch (userModel) {
      UserModelADM(:final workDays, :final workHours) => (
          workDays: workDays!,
          workHours: workHours!,
        ),
      UserModelEmployee(:final workDays, :final workHours) => (
          workDays: workDays,
          workHours: workHours,
        ),
      UserModel() => throw UnimplementedError(),
    };

    ref.listen(scheduleVmProvider.select((state) => state.status), (_, status) {
      switch (status) {
        case ScheduleStateStatus.initial:
          break;
        case ScheduleStateStatus.success:
          Messages.showSuccess('Agendamento realizado com sucesso', context);
          Navigator.of(context).pop();
        case ScheduleStateStatus.error:
          Messages.showError('Erro ao realizar agendamento', context);
          log('❌ Erro ao realizar agendamento');
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Agendar cliente'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const BarbershopUserAvatar(
              hideUploadButton: true,
            ),
            const SizedBox(height: 24),
            Text(userModel.name, style: BarbershopTheme.mediumTitleStyle),
            const SizedBox(height: 36),
            Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: clientEC,
                    validator: Validatorless.multiple([
                      Validatorless.required('Cliente obrigatório'),
                      Validatorless.min(1, 'Nome do cliente muito curto'),
                    ]),
                    onTapOutside: (_) => context.unfocus(),
                    decoration: const InputDecoration(
                      label: Text('Nome do cliente'),
                      hintText: 'Nome do cliente',
                    ),
                  ),
                  const SizedBox(height: 32),
                  TextFormField(
                    controller: dateSelectedEC,
                    validator: Validatorless.required(
                        'Selecione a data do agendamento'),
                    onTap: () {
                      setState(() {
                        showCalendar = true;
                      });
                      context.unfocus();
                    },
                    readOnly: true,
                    decoration: const InputDecoration(
                      label: Text('Selecione uma data'),
                      hintText: 'Selecione uma data',
                      suffixIcon: Icon(
                        BarbershopIcons.calendar,
                        color: ColorsTheme.brown,
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      const SizedBox(height: 24),
                      Offstage(
                        offstage: !showCalendar,
                        child: ScheduleCalendar(
                          cancelPressed: () {
                            setState(() {
                              showCalendar = false;
                            });
                          },
                          okPressed: (DateTime value) {
                            setState(() {
                              dateSelectedEC.text = dateFormat.format(value);
                              scheduleVM.dateSelected(value);
                              showCalendar = false;
                            });
                          },
                          workDays: employeeData.workDays,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  BarbershopHoursGrid.singleSelection(
                    startTime: 6,
                    endTime: 23,
                    enabledHours: employeeData.workHours,
                    onHourPressed: scheduleVM.hourSelected,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      switch (formKey.currentState?.validate()) {
                        case null || false:
                          Messages.showError('Dados incompletos', context);
                        case true:
                          // API
                          final hourSelected = ref.watch(scheduleVmProvider
                              .select((state) => state.scheduledHour != null));
                          if (hourSelected) {
                            scheduleVM.register(
                                userModel: userModel, client: clientEC.text);
                          } else {
                            Messages.showError(
                                'Por favor selecione um horário', context);
                          }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(56),
                    ),
                    child: const Text('AGENDAR'),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
