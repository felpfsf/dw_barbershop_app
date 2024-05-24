import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dw_barbershop/src/core/exceptions/repository_exception.dart';
import 'package:dw_barbershop/src/core/fp/either.dart';
import 'package:dw_barbershop/src/core/fp/nil.dart';
import 'package:dw_barbershop/src/core/restClient/rest_client.dart';

import './schedule_repository.dart';

class ScheduleRepositoryImpl implements ScheduleRepository {
  final RestClient restClient;

  ScheduleRepositoryImpl({
    required this.restClient,
  });

  @override
  Future<Either<RepositoryException, Nil>> registerScheduleClient(
      ({
        int barbershopId,
        String client,
        DateTime date,
        int hour,
        int userId
      }) scheduleData) async {
    try {
      await restClient.auth.post('/schedules', data: {
        'barbershop_id': scheduleData.barbershopId,
        'user_id': scheduleData.userId,
        'client_name': scheduleData.client,
        'date': scheduleData.date.toIso8601String(),
        'hour': scheduleData.hour,
      });

      return Right(nil);
    } on DioException catch (e, s) {
      log('❌ Erro ao realizar agendamento', error: e, stackTrace: s);
      return Left(
          RepositoryException(message: '❌ Erro ao realizar agendamento'));
    }
  }
}
