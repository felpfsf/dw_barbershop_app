import 'package:syncfusion_flutter_calendar/calendar.dart';

class AppointmentDataSource extends CalendarDataSource {
  @override
  List<dynamic>? get appointments => [
        Appointment(
          startTime: DateTime.now(),
          endTime: DateTime.now().add(
            const Duration(hours: 1),
          ),
          subject: 'Cliente 1',
        ),
        Appointment(
          startTime: DateTime.now().add(
            const Duration(hours: 2),
          ),
          endTime: DateTime.now().add(
            const Duration(hours: 3),
          ),
          subject: 'Cliente 2',
        ),
        Appointment(
          startTime: DateTime.now().add(
            const Duration(hours: 4),
          ),
          endTime: DateTime.now().add(
            const Duration(hours: 5),
          ),
          subject: 'Cliente 3',
        ),
      ];
}
