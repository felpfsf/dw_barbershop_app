import 'package:dw_barbershop/src/core/ui/barbershop_icons.dart';
import 'package:dw_barbershop/src/core/ui/barbershop_theme.dart';
import 'package:dw_barbershop/src/features/home/widgets/employee_tile.dart';
import 'package:dw_barbershop/src/features/home/widgets/home_header.dart';
import 'package:flutter/material.dart';

class HomeAdmPage extends StatelessWidget {
  const HomeAdmPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const AddEmployeeFloatButton(),
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: HomeHeader(),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => const EmployeeTile(),
              childCount: 20,
            ),
          ),
        ],
      ),
    );
  }
}

class AddEmployeeFloatButton extends StatelessWidget {
  const AddEmployeeFloatButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {},
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
