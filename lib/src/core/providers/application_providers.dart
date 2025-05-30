import 'package:dw_barbershop/src/core/env.dart';
import 'package:dw_barbershop/src/core/fp/either.dart';
import 'package:dw_barbershop/src/core/restClient/rest_client.dart';
import 'package:dw_barbershop/src/core/ui/barbershop_nav_global_key.dart';
import 'package:dw_barbershop/src/models/barbershop_model.dart';
import 'package:dw_barbershop/src/models/user_model.dart';
import 'package:dw_barbershop/src/repositories/barbershop/barbershop_repository.dart';
import 'package:dw_barbershop/src/repositories/barbershop/barbershop_repository_impl.dart';
import 'package:dw_barbershop/src/repositories/schedule/schedule_repository.dart';
import 'package:dw_barbershop/src/repositories/schedule/schedule_repository_impl.dart';
import 'package:dw_barbershop/src/repositories/user/user_repository.dart';
import 'package:dw_barbershop/src/repositories/user/user_repository_impl.dart';
import 'package:dw_barbershop/src/services/user/user_login_service.dart';
import 'package:dw_barbershop/src/services/user/user_login_service_impl.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'application_providers.g.dart';

@Riverpod(keepAlive: true)
RestClient restClient(RestClientRef ref) => RestClient(Env.backendBaseUrl);

@Riverpod(keepAlive: true)
UserRepository userRepository(UserRepositoryRef ref) =>
    UserRepositoryImpl(restClient: ref.read(restClientProvider));

@Riverpod(keepAlive: true)
UserLoginService userLoginService(UserLoginServiceRef ref) =>
    UserLoginServiceImpl(userRepository: ref.read(userRepositoryProvider));

@Riverpod(keepAlive: true)
Future<UserModel> getMe(GetMeRef ref) async {
  final result = await ref.watch(userRepositoryProvider).me();

  return switch (result) {
    Right(value: final userModel) => userModel,
    Left(value: final exception) => throw exception,
  };
}

@Riverpod(keepAlive: true)
BarbershopRepository barbershopRepository(BarbershopRepositoryRef ref) =>
    BarbershopRepositoryImpl(restClient: ref.watch(restClientProvider));

@Riverpod(keepAlive: true)
Future<BarbershopModel> getMyBarbershop(GetMyBarbershopRef ref) async {
  final userModel = await ref.watch(getMeProvider.future);
  final barbershoRepository = ref.watch(barbershopRepositoryProvider);

  final result = await barbershoRepository.getMyBarbershop(userModel);

  return switch (result) {
    Right(value: final barbershop) => barbershop,
    Left(value: final exception) => throw exception,
  };
}

@riverpod
Future<void> logout(LogoutRef ref) async {
  final sp = await SharedPreferences.getInstance();

  sp.clear();

  ref.invalidate(getMeProvider);
  ref.invalidate(getMyBarbershopProvider);

  Navigator.of(BarbershopNavGlobalKey.instance.navKey.currentContext!)
      .pushNamedAndRemoveUntil(
    '/auth/login',
    (route) => false,
  );
}

@riverpod
ScheduleRepository scheduleRepository(ScheduleRepositoryRef ref) =>
    ScheduleRepositoryImpl(restClient: ref.read(restClientProvider));
