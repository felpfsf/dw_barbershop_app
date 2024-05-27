import 'dart:developer';

import 'package:dw_barbershop/src/core/providers/application_providers.dart';
import 'package:dw_barbershop/src/core/ui/barbershop_theme.dart';
import 'package:dw_barbershop/src/core/ui/widgets/barbershop_loader.dart';
import 'package:dw_barbershop/src/core/ui/widgets/barbershop_user_avatar.dart';
import 'package:dw_barbershop/src/features/home/employee/home_employee_provider.dart';
import 'package:dw_barbershop/src/features/home/widgets/home_header.dart';
import 'package:dw_barbershop/src/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeEmployeePage extends ConsumerWidget {
  const HomeEmployeePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userModelAsync = ref.watch(getMeProvider);

    return Scaffold(
      body: userModelAsync.when(
        loading: () => const BarbershopLoader(),
        error: (e, s) {
          log('Erro ao carregar colaboradores', error: e, stackTrace: s);
          return const Center(
            child: Text(
              'Erro ao carregar colaboradores',
              style: BarbershopTheme.boldBodyStyle,
            ),
          );
        },
        data: (user) => EmployeeHomeInfo(
          ref: ref,
          user: user,
        ),
      ),
    );
  }
}

class EmployeeHomeInfo extends StatelessWidget {
  final UserModel user;
  final WidgetRef ref;
  const EmployeeHomeInfo({
    super.key,
    required this.user,
    required this.ref,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(
          child: HomeHeader.withoutEmployeeFilter(),
        ),
        SliverFillRemaining(
          hasScrollBody: false,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                const BarbershopUserAvatar(
                  hideUploadButton: true,
                ),
                const SizedBox(height: 24),
                Text(
                  user.name,
                  style: BarbershopTheme.mediumTitleStyle,
                ),
                const SizedBox(height: 24),
                Container(
                  // width: MediaQuery.sizeOf(context).width * .8,
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    border: Border.all(color: ColorsTheme.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Consumer(
                        builder: (context, ref, child) {
                          final totalSchedulesAsync = ref
                              .watch(getTotalSchedulesTodayProvider(user.id));
                          return totalSchedulesAsync.when(
                            error: (e, s) {
                              log('Erro ao carregar total de agendamentos',
                                  error: e, stackTrace: s);
                              return const Center(
                                child: Text(
                                  'Erro ao carregar total de agendamentos',
                                  style: BarbershopTheme.boldBodyStyle,
                                ),
                              );
                            },
                            loading: () => const BarbershopLoader(),
                            skipLoadingOnRefresh: false,
                            data: (schedules) => Text(
                              '$schedules',
                              style: BarbershopTheme.mediumTitleStyle.copyWith(
                                color: ColorsTheme.brown,
                                fontSize: 26,
                              ),
                            ),
                          );
                        },
                      ),
                      const Text(
                        'Clientes Hoje',
                        style: BarbershopTheme.mediumBodyStyle,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(56),
                  ),
                  onPressed: () async {
                    await Navigator.of(context)
                        .pushNamed('/schedule', arguments: user);

                    ref.invalidate(getTotalSchedulesTodayProvider);
                  },
                  child: const Text('AGENDAR CLIENTE'),
                ),
                const SizedBox(height: 24),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size.fromHeight(56),
                  ),
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed('/employee/schedule', arguments: user);
                  },
                  child: const Text('VER AGENDA'),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
