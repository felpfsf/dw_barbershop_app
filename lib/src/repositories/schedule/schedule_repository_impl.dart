import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dw_barbershop/src/core/exceptions/repository_exception.dart';
import 'package:dw_barbershop/src/core/fp/either.dart';
import 'package:dw_barbershop/src/core/fp/nil.dart';
import 'package:dw_barbershop/src/core/restClient/rest_client.dart';
import 'package:dw_barbershop/src/models/schedule_model.dart';

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

  @override
  Future<Either<RepositoryException, List<ScheduleModel>>> findScheduleByDate(
      ({DateTime date, int userId}) scheduleFilter) async {
    try {
      final Response(:List data) = await restClient.auth.get('/schedules',
          queryParameters: {
            'date': scheduleFilter.date.toIso8601String(),
            'user_id': scheduleFilter.userId
          });

      final schedules = data.map((json) {
        print("🚀 ~ ScheduleRepositoryImpl ~ finalschedules=data.map ~ $json");
        return ScheduleModel.fromMap(json);
      }).toList();

      return Right(schedules);
    } on DioException catch (e, s) {
      log('❌ Erro ao buscar agendamentos', error: e, stackTrace: s);
      return Left(
          RepositoryException(message: '❌ Erro ao buscar agendamentos'));
    } on ArgumentError catch (e, s) {
      log('❌ Agendamentos(JSON) inválido', error: e, stackTrace: s);
      return Left(
          RepositoryException(message: '❌ Agendamentos(JSON) inválido'));
    }
  }
}
