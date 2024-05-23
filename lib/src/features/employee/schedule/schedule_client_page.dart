import 'package:dw_barbershop/src/core/ui/barbershop_icons.dart';
import 'package:dw_barbershop/src/core/ui/barbershop_theme.dart';
import 'package:dw_barbershop/src/core/ui/helpers/helper_form.dart';
import 'package:dw_barbershop/src/core/ui/helpers/messages.dart';
import 'package:dw_barbershop/src/core/ui/widgets/barbershop_hours_grid.dart';
import 'package:dw_barbershop/src/core/ui/widgets/barbershop_user_avatar.dart';
import 'package:dw_barbershop/src/features/home/widgets/schedule_calendar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:validatorless/validatorless.dart';

class ScheduleClientPage extends StatefulWidget {
  const ScheduleClientPage({super.key});

  @override
  State<ScheduleClientPage> createState() => _ScheduleClientPageState();
}

class _ScheduleClientPageState extends State<ScheduleClientPage> {
  var dateFormat = DateFormat('dd/MM/yyyy');
  bool showCalendar = false;
  final formKey = GlobalKey<FormState>();
  final clientEC = TextEditingController();
  final dateSelectedEC = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    clientEC.dispose();
    dateSelectedEC.dispose();
  }

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
            Form(
              child: Column(
                children: [
                  TextFormField(
                    controller: clientEC,
                    validator: Validatorless.multiple([
                      Validatorless.required('Cliente obrigatório'),
                      Validatorless.min(1, 'Nome do cliente muito curto'),
                    ]),
                    onTapOutside: (_) => context.unfocus(),
                    decoration: const InputDecoration(
                      label: Text('Nome do cliente'),
                      hintText: 'Nome do cliente',
                    ),
                  ),
                  const SizedBox(height: 32),
                  TextFormField(
                    controller: dateSelectedEC,
                    validator: Validatorless.required(
                        'Selecione a data do agendamento'),
                    onTap: () {
                      setState(() {
                        showCalendar = true;
                      });
                      context.unfocus();
                    },
                    readOnly: true,
                    decoration: const InputDecoration(
                      label: Text('Selecione uma data'),
                      hintText: 'Selecione uma data',
                      suffixIcon: Icon(
                        BarbershopIcons.calendar,
                        color: ColorsTheme.brown,
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      const SizedBox(height: 24),
                      Offstage(
                        offstage: !showCalendar,
                        child: ScheduleCalendar(
                          cancelPressed: () {
                            setState(() {
                              showCalendar = false;
                            });
                          },
                          okPressed: (DateTime value) {
                            setState(() {
                              dateSelectedEC.text = dateFormat.format(value);
                              showCalendar = false;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  BarbershopHoursGrid.singleSelection(
                    startTime: 6,
                    endTime: 22,
                    enabledHours: const [6, 7, 8],
                    onHourPressed: (value) {},
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      switch (formKey.currentState?.validate()) {
                        case null || false:
                          Messages.showError('Dados incompletos', context);
                        case true:
                        // API
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(56),
                    ),
                    child: const Text('AGENDAR'),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
