import 'package:dw_barbershop/src/core/ui/barbershop_theme.dart';
import 'package:dw_barbershop/src/core/ui/helpers/messages.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class ScheduleCalendar extends StatefulWidget {
  final VoidCallback cancelPressed;
  final ValueChanged<DateTime> okPressed;
  final List<String> workDays;

  const ScheduleCalendar({
    super.key,
    required this.cancelPressed,
    required this.okPressed,
    required this.workDays,
  });

  @override
  State<ScheduleCalendar> createState() => _ScheduleCalendarState();
}

class _ScheduleCalendarState extends State<ScheduleCalendar> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  late final List<int> weekDaysEnabled;

  int convertWeekDay(String day) {
    return switch (day.toLowerCase()) {
      'seg' => DateTime.monday,
      'ter' => DateTime.tuesday,
      'qua' => DateTime.wednesday,
      'qui' => DateTime.thursday,
      'sex' => DateTime.friday,
      'sab' => DateTime.saturday,
      'dom' => DateTime.sunday,
      _ => 0,
    };
  }

  @override
  void initState() {
    weekDaysEnabled = widget.workDays.map(convertWeekDay).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorsTheme.greyLight,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          TableCalendar(
            headerStyle: const HeaderStyle(titleCentered: true),
            focusedDay: _focusedDay,
            firstDay: DateTime.utc(2024, 01, 01),
            lastDay: DateTime.now().add(const Duration(days: 365 * 10)),
            calendarFormat: CalendarFormat.month,
            locale: 'pt_BR',
            availableGestures: AvailableGestures.horizontalSwipe,
            availableCalendarFormats: const {
              CalendarFormat.month: 'Month',
            },
            enabledDayPredicate: (day) => weekDaysEnabled.contains(day.weekday),
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              if (!isSameDay(_selectedDay, selectedDay)) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              }
            },
            calendarStyle: CalendarStyle(
              selectedDecoration: const BoxDecoration(
                color: ColorsTheme.brown,
                shape: BoxShape.circle,
              ),
              todayDecoration: BoxDecoration(
                color: ColorsTheme.brown.withOpacity(0.4),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  widget.cancelPressed();
                },
                child: Text(
                  'Cancelar',
                  style: BarbershopTheme.mediumBodyStyle.copyWith(
                    color: ColorsTheme.brown,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  if (_selectedDay == null) {
                    Messages.showError('Por favor escolha uma data', context);
                    return;
                  }
                  widget.okPressed(_selectedDay!);
                },
                child: Text(
                  'OK',
                  style: BarbershopTheme.mediumBodyStyle.copyWith(
                    color: ColorsTheme.brown,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
