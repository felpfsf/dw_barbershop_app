import 'package:dw_barbershop/src/core/ui/barbershop_theme.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class ScheduleCalendar extends StatefulWidget {
  const ScheduleCalendar({super.key});

  @override
  State<ScheduleCalendar> createState() => _ScheduleCalendarState();
}

class _ScheduleCalendarState extends State<ScheduleCalendar> {
  @override
  Widget build(BuildContext context) {
    DateTime? daySelected;

    return Column(
      children: [
        TableCalendar(
          headerStyle: const HeaderStyle(titleCentered: true),
          focusedDay: DateTime.now(),
          firstDay: DateTime.utc(2024, 01, 01),
          lastDay: DateTime.now().add(const Duration(days: 365 * 10)),
          calendarFormat: CalendarFormat.month,
          locale: 'pt_BR',
          availableGestures: AvailableGestures.horizontalSwipe,
          availableCalendarFormats: const {
            CalendarFormat.month: 'Month',
          },
          selectedDayPredicate: (day) {
            return isSameDay(daySelected, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            if (!isSameDay(daySelected, selectedDay)) {
              setState(() {
                daySelected = selectedDay;
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
      ],
    );
  }
}
