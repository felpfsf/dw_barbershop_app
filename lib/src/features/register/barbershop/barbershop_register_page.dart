import 'package:dw_barbershop/src/core/ui/helpers/helper_form.dart';
import 'package:dw_barbershop/src/core/ui/helpers/messages.dart';
import 'package:dw_barbershop/src/core/ui/widgets/barbershop_hours_grid.dart';
import 'package:dw_barbershop/src/core/ui/widgets/barbershop_weekdays_grid.dart';
import 'package:dw_barbershop/src/features/register/barbershop/barbershop_register_state.dart';
import 'package:dw_barbershop/src/features/register/barbershop/barbershop_register_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:validatorless/validatorless.dart';

class BarbershopRegisterPage extends ConsumerStatefulWidget {
  const BarbershopRegisterPage({super.key});

  @override
  ConsumerState<BarbershopRegisterPage> createState() =>
      _BarbershopRegisterPageState();
}

class _BarbershopRegisterPageState
    extends ConsumerState<BarbershopRegisterPage> {
  final formKey = GlobalKey<FormState>();
  final nameEC = TextEditingController(text: 'BarberShop');
  final emailEC = TextEditingController(text: 'barbershop@barbershop.com');

  @override
  void dispose() {
    nameEC.dispose();
    emailEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final barbershopRegisterVM =
        ref.watch(barbershopRegisterVmProvider.notifier);

    ref.listen(barbershopRegisterVmProvider, (_, state) {
      switch (state.status) {
        case BarbershopRegisterStateStatus.initial:
          break;
        case BarbershopRegisterStateStatus.error:
          Messages.showError(
              'Desculpe! Erro ao registrar estabelecimento', context);
        case BarbershopRegisterStateStatus.success:
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/home/adm', (route) => false);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar estabelecimento'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: nameEC,
                  onTapOutside: (_) => context.unfocus(),
                  validator: Validatorless.multiple([
                    Validatorless.required('Nome é obrigatório'),
                    Validatorless.min(3, 'Nome muito curto'),
                  ]),
                  decoration: const InputDecoration(
                    label: Text('Nome do estabelecimento'),
                    hintText: 'Nome do estabelecimento',
                  ),
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: emailEC,
                  onTapOutside: (_) => context.unfocus(),
                  validator: Validatorless.multiple([
                    Validatorless.required('E-mail é obrigatório'),
                    Validatorless.email('E-mail inválido'),
                  ]),
                  decoration: const InputDecoration(
                    label: Text('E-mail do estabelecimento'),
                    hintText: 'E-mail do estabelecimento',
                  ),
                ),
                const SizedBox(height: 24),
                BarbershopWeekdaysGrid(
                  onDayPressed: (weekday) {
                    debugPrint(weekday);
                    barbershopRegisterVM.addOrRemoveOpeningDay(weekday);
                  },
                ),
                const SizedBox(height: 24),
                BarbershopHoursGrid(
                  startTime: 6,
                  endTime: 23,
                  onHourPressed: (hour) {
                    debugPrint('$hour');
                    barbershopRegisterVM.addOrRemoveOpeningHours(hour);
                  },
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    switch (formKey.currentState?.validate()) {
                      case false || null:
                        Messages.showError('Formulário inválido', context);
                      case true:
                        barbershopRegisterVM.register(
                          nameEC.text,
                          emailEC.text,
                        );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(56),
                  ),
                  child: const Text('CADASTRAR ESTABELECIMENTO'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
