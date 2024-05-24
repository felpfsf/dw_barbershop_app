import 'package:dw_barbershop/src/core/exceptions/repository_exception.dart';
import 'package:dw_barbershop/src/core/fp/either.dart';
import 'package:dw_barbershop/src/core/fp/nil.dart';

abstract interface class ScheduleRepository {
  Future<Either<RepositoryException, Nil>> registerScheduleClient(
      ({
        int barbershopId,
        int userId,
        String client,
        DateTime date,
        int hour
      }) scheduleData);
}
