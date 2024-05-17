import 'dart:developer';

import 'package:dw_barbershop/src/core/providers/application_providers.dart';
import 'package:dw_barbershop/src/core/ui/barbershop_theme.dart';
import 'package:dw_barbershop/src/core/ui/helpers/helper_form.dart';
import 'package:dw_barbershop/src/core/ui/helpers/messages.dart';
import 'package:dw_barbershop/src/core/ui/widgets/barbershop_hours_grid.dart';
import 'package:dw_barbershop/src/core/ui/widgets/barbershop_loader.dart';
import 'package:dw_barbershop/src/core/ui/widgets/barbershop_user_avatar.dart';
import 'package:dw_barbershop/src/core/ui/widgets/barbershop_weekdays_grid.dart';
import 'package:dw_barbershop/src/features/employee/register/employee_register_state.dart';
import 'package:dw_barbershop/src/features/employee/register/employee_register_vm.dart';
import 'package:dw_barbershop/src/models/barbershop_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:validatorless/validatorless.dart';

class EmployeeRegisterPage extends ConsumerStatefulWidget {
  const EmployeeRegisterPage({super.key});

  @override
  ConsumerState<EmployeeRegisterPage> createState() =>
      _EmployeeRegisterPageState();
}

class _EmployeeRegisterPageState extends ConsumerState<EmployeeRegisterPage> {
  final formKey = GlobalKey<FormState>();
  final nameEC = TextEditingController(text: "Tester Employee 6");
  final emailEC = TextEditingController(text: "employee06@barbershop.com.br");
  final passwordEC = TextEditingController(text: "123123");

  bool registerAdm = false;

  @override
  void dispose() {
    nameEC.dispose();
    emailEC.dispose();
    passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final employeeRegisterVm = ref.watch(employeeRegisterVmProvider.notifier);
    final barbershopAsyncValue = ref.watch(getMyBarbershopProvider);

    ref.listen(employeeRegisterVmProvider.select((state) => state.status),
        (_, status) {
      switch (status) {
        case EmployeeRegisterStateStatus.initial:
          break;
        case EmployeeRegisterStateStatus.success:
          Messages.showSuccess('Colaborador regitrado com sucesso', context);
          Navigator.of(context).pop();
        case EmployeeRegisterStateStatus.error:
          Messages.showError('Erro ao registrar colaborador', context);
      }
    });
    return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastrar colaborador'),
        ),
        body: barbershopAsyncValue.when(
          error: (error, stackTrace) {
            log('Erro ao carregar a página',
                error: error, stackTrace: stackTrace);
            return const Center(
              child: Text('Erro ao carregar a página'),
            );
          },
          loading: () => const BarbershopLoader(),
          data: (barbershopModel) {
            final BarbershopModel(
              :openingDays,
              :openingHours,
            ) = barbershopModel;
            final List<int> sortedOpeningHours = openingHours.toList()..sort();

            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    const BarbershopUserAvatar(),
                    const SizedBox(height: 32),
                    Row(
                      children: [
                        Checkbox.adaptive(
                          value: registerAdm,
                          onChanged: (bool? value) {
                            setState(() {
                              registerAdm = !registerAdm;
                              employeeRegisterVm.setRegisterAdm(registerAdm);
                            });
                          },
                        ),
                        const Expanded(
                          child: Text(
                            'Sou admistrador e quero me cadastrar como colaborador',
                            style: BarbershopTheme.regularBodyStyle,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Offstage(
                      offstage: registerAdm,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: nameEC,
                            onTapOutside: (_) => context.unfocus(),
                            validator: Validatorless.multiple([
                              Validatorless.required('Nome obrigatório'),
                              Validatorless.min(3, 'Nome muito curto'),
                            ]),
                            decoration: const InputDecoration(
                              labelText: 'Nome',
                              hintText: 'Nome',
                            ),
                          ),
                          const SizedBox(height: 24),
                          TextFormField(
                            controller: emailEC,
                            onTapOutside: (_) => context.unfocus(),
                            validator: Validatorless.multiple([
                              Validatorless.required('Email obrigatório'),
                              Validatorless.email('Email inválido'),
                            ]),
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              labelText: 'Email',
                              hintText: 'Email',
                            ),
                          ),
                          const SizedBox(height: 24),
                          TextFormField(
                            controller: passwordEC,
                            onTapOutside: (_) => context.unfocus(),
                            obscureText: true,
                            validator: Validatorless.multiple([
                              Validatorless.required('Senha obrigatória'),
                              Validatorless.min(6,
                                  'Senha muito curta, deve conter pelo menos 6 caracteres'),
                            ]),
                            decoration: const InputDecoration(
                              labelText: 'Senha',
                              hintText: 'Senha',
                            ),
                          ),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                    BarbershopWeekdaysGrid(
                      onDayPressed: employeeRegisterVm.addOrRemoveWorkDay,
                      enabledDays: openingDays,
                    ),
                    const SizedBox(height: 24),
                    BarbershopHoursGrid(
                      startTime: sortedOpeningHours.first,
                      endTime: sortedOpeningHours.last,
                      onHourPressed: employeeRegisterVm.addOrRemoveWorkhour,
                      enabledHours: openingHours,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {
                        switch (formKey.currentState?.validate()) {
                          case false || null:
                            Messages.showError(
                              'Preencha todos os campos',
                              context,
                            );
                          case true:
                            final EmployeeRegisterState(
                              workDays: List(isNotEmpty: hasWorkDays),
                              workHours: List(isNotEmpty: hasWorkHours),
                            ) = ref.watch(employeeRegisterVmProvider);

                            if (!hasWorkDays || !hasWorkHours) {
                              Messages.showError(
                                'Selecione pelo menos um dia e hora de atendimento',
                                context,
                              );
                              return;
                            }

                            final name = nameEC.text;
                            final email = emailEC.text;
                            final password = passwordEC.text;

                            employeeRegisterVm.register(
                              name,
                              email,
                              password,
                            );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(56),
                      ),
                      child: const Text('Cadastrar colaborador'),
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
