import 'dart:developer';

import 'package:dw_barbershop/src/core/ui/barbershop_icons.dart';
import 'package:dw_barbershop/src/core/ui/barbershop_theme.dart';
import 'package:dw_barbershop/src/core/ui/widgets/barbershop_loader.dart';
import 'package:dw_barbershop/src/features/home/adm/home_adm_state.dart';
import 'package:dw_barbershop/src/features/home/adm/home_adm_vm.dart';
import 'package:dw_barbershop/src/features/home/widgets/employee_tile.dart';
import 'package:dw_barbershop/src/features/home/widgets/home_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeAdmPage extends ConsumerWidget {
  const HomeAdmPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeAdmVmProvider);

    return Scaffold(
      floatingActionButton: const AddEmployeeFloatButton(),
      body: homeState.when(
        data: (HomeAdmState data) {
          return CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(
                child: HomeHeader(),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) =>
                      EmployeeTile(employee: data.employees[index]),
                  childCount: data.employees.length,
                ),
              ),
            ],
          );
        },
        error: (Object error, StackTrace stackTrace) {
          log('Erro ao carregar colaboradores',
              error: error, stackTrace: stackTrace);
          return const Center(
            child: Text(
              'Erro ao carregar página',
              style: BarbershopTheme.boldBodyStyle,
            ),
          );
        },
        loading: () => const BarbershopLoader(),
      ),
    );
  }
}

class AddEmployeeFloatButton extends ConsumerWidget {
  const AddEmployeeFloatButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FloatingActionButton(
      onPressed: () async {
        await Navigator.of(context).pushNamed('/employee/register');
        ref.invalidate(homeAdmVmProvider);
      },
      shape: const CircleBorder(),
      backgroundColor: ColorsTheme.brown,
      child: const CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 12,
        child: Icon(
          BarbershopIcons.addEmployee,
          color: ColorsTheme.brown,
        ),
      ),
    );
  }
}
