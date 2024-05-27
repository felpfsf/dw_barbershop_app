import 'package:dw_barbershop/src/core/ui/barbershop_theme.dart';
import 'package:dw_barbershop/src/models/schedule_model.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class AppointmentDataSource extends CalendarDataSource {
  final List<ScheduleModel> schedules;

  AppointmentDataSource({
    required this.schedules,
  });

  @override
  List<dynamic>? get appointments {
    return schedules.map((e) {
      final ScheduleModel(
        date: DateTime(:year, :month, :day),
        :hour,
        :clientName,
      ) = e;

      final startTime = DateTime(year, month, day, hour, 0, 0);
      final endTime = DateTime(year, month, day, hour + 1, 0, 0);

      return Appointment(
        startTime: startTime,
        endTime: endTime,
        subject: clientName,
        color: ColorsTheme.brown,
      );
    }).toList();
  }
  // List<dynamic>? get appointments => [
  //       Appointment(
  //         startTime: DateTime.now(),
  //         endTime: DateTime.now().add(
  //           const Duration(hours: 1),
  //         ),
  //         subject: 'Cliente 1',
  //         color: ColorsTheme.brown,
  //       ),
  //       Appointment(
  //         startTime: DateTime.now().add(
  //           const Duration(hours: 2),
  //         ),
  //         endTime: DateTime.now().add(
  //           const Duration(hours: 3),
  //         ),
  //         subject: 'Cliente 2',
  //       ),
  //       Appointment(
  //         startTime: DateTime.now().add(
  //           const Duration(hours: 4),
  //         ),
  //         endTime: DateTime.now().add(
  //           const Duration(hours: 5),
  //         ),
  //         subject: 'Cliente 3',
  //       ),
  //     ];
}
