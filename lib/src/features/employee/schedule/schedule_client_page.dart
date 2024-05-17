import 'package:dw_barbershop/src/core/ui/barbershop_icons.dart';
import 'package:dw_barbershop/src/core/ui/barbershop_theme.dart';
import 'package:dw_barbershop/src/core/ui/helpers/helper_form.dart';
import 'package:dw_barbershop/src/core/ui/widgets/barbershop_hours_grid.dart';
import 'package:dw_barbershop/src/core/ui/widgets/barbershop_user_avatar.dart';
import 'package:dw_barbershop/src/features/home/widgets/schedule_calendar.dart';
import 'package:flutter/material.dart';

class ScheduleClientPage extends StatelessWidget {
  const ScheduleClientPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agendar cliente'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const BarbershopUserAvatar(
              hideUploadButton: true,
            ),
            const SizedBox(height: 24),
            const Text('Nome do colaborador'),
            const SizedBox(height: 36),
            TextFormField(
              onTapOutside: (_) => context.unfocus(),
              decoration: const InputDecoration(
                label: Text('Nome do cliente'),
                hintText: 'Nome do cliente',
              ),
            ),
            const SizedBox(height: 32),
            TextFormField(
              readOnly: true,
              decoration: InputDecoration(
                label: const Text('Selecione uma data'),
                hintText: 'Selecione uma data',
                suffixIcon: IconButton(
                  icon: const Icon(BarbershopIcons.calendar),
                  color: ColorsTheme.brown,
                  onPressed: () {},
                ),
              ),
            ),
            const SizedBox(height: 24),
            const ScheduleCalendar(),
            const SizedBox(height: 24),
            BarbershopHoursGrid(
              startTime: 6,
              endTime: 22,
              onHourPressed: (value) {},
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(56),
              ),
              child: const Text('AGENDAR'),
            )
          ],
        ),
      ),
    );
  }
}
