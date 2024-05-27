import 'dart:developer';

import 'package:dw_barbershop/src/core/ui/barbershop_theme.dart';
import 'package:dw_barbershop/src/core/ui/widgets/barbershop_loader.dart';
import 'package:dw_barbershop/src/features/employee/schedule/appointment_data_source.dart';
import 'package:dw_barbershop/src/features/employee/schedule/employee_schedule_vm.dart';
import 'package:dw_barbershop/src/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class EmployeeSchedulePage extends ConsumerStatefulWidget {
  const EmployeeSchedulePage({super.key});

  @override
  ConsumerState<EmployeeSchedulePage> createState() =>
      _EmployeeSchedulePageState();
}

class _EmployeeSchedulePageState extends ConsumerState<EmployeeSchedulePage> {
  late DateTime _dateSelected;

  @override
  void initState() {
    final DateTime(:year, :month, :day) = DateTime.now();
    _dateSelected = DateTime(year, month, day, 0, 0, 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final UserModel(id: userId, :name) =
        ModalRoute.of(context)!.settings.arguments as UserModel;

    final scheduleAsync =
        ref.watch(EmployeeScheduleVmProvider(userId, _dateSelected));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Agenda'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 44),
          Text(
            name,
            style: BarbershopTheme.mediumTitleStyle,
          ),
          const SizedBox(height: 44),
          scheduleAsync.when(
            loading: () => const BarbershopLoader(),
            error: (error, stackTrace) {
              log('Erro ao carregar agendamentos',
                  error: error, stackTrace: stackTrace);
              return const Center(child: Text('Erro ao carregar agendamentos'));
            },
            data: (schedules) {
              return Expanded(
                child: SfCalendar(
                  allowViewNavigation: true,
                  view: CalendarView.day,
                  showNavigationArrow: true,
                  todayHighlightColor: ColorsTheme.brown,
                  showDatePickerButton: true,
                  showTodayButton: true,
                  onTap: (calendarTapDetails) {
                    if (calendarTapDetails.appointments != null &&
                        calendarTapDetails.appointments!.isNotEmpty) {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          final dateFormat = DateFormat('dd/MM/yyyy HH:mm');
                          return SizedBox(
                            height: 200,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Cliente: ${calendarTapDetails.appointments?.first.subject}',
                                  ),
                                  Text(
                                    'Horário: ${dateFormat.format(calendarTapDetails.date ?? DateTime.now())}',
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                  onViewChanged: (viewChangedDetails) {
                    final visibleDates = viewChangedDetails.visibleDates;
                    if (visibleDates.isNotEmpty) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        setState(() {
                          _dateSelected = visibleDates.first;
                        });
                      });
                    }
                  },
                  dataSource: AppointmentDataSource(schedules: schedules),

                  // Exemplo de customização do Widget, ao clicar ele abre um modal do tipo bottomsheet
                  // appointmentBuilder: (context, calendarAppointmentDetails) {
                  //   return Container(
                  //     decoration: BoxDecoration(
                  //       color: ColorsTheme.brown,
                  //       shape: BoxShape.rectangle,
                  //       borderRadius: BorderRadius.circular(5),
                  //     ),
                  //     child: Center(
                  //       child: Text(
                  //         calendarAppointmentDetails.appointments.first.subject,
                  //         style: BarbershopTheme.regularBodyStyle.copyWith(
                  //           color: Colors.white,
                  //         ),
                  //       ),
                  //     ),
                  //   );
                  // },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
