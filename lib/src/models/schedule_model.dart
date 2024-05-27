class ScheduleModel {
  final int id;
  final int barbershopId;
  final int userId;
  final String clientName;
  final DateTime date;
  final int hour;

  ScheduleModel({
    required this.id,
    required this.barbershopId,
    required this.userId,
    required this.clientName,
    required this.date,
    required this.hour,
  });

  factory ScheduleModel.fromMap(Map<String, dynamic> json) {
    return switch (json) {
      {
        "id": int id,
        "barbershop_id": int barbershopId,
        "user_id": int userId,
        "client_name": String clientName,
        "date": String date,
        "hour": int hour,
      } =>
        ScheduleModel(
          id: id,
          barbershopId: barbershopId,
          userId: userId,
          clientName: clientName,
          date: DateTime.parse(date),
          hour: hour,
        ),
      _ => throw ArgumentError('Erro ao transformar ScheduleModel(json)'),
    };
  }
}

// [
//   {
//     "id": 1,
//     "barbershop_id": 2,
//     "user_id": 5,
//     "client_name": "teste",
//     "date": "2023-08-09T00:00:00.000Z",
//     "time": 8
//   }
// ]