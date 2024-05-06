import 'package:dw_barbershop/src/core/ui/helpers/helper_form.dart';
import 'package:dw_barbershop/src/core/ui/widgets/barbershop_weekdays_grid.dart';
import 'package:flutter/material.dart';
import 'package:validatorless/validatorless.dart';

class BarbershopRegisterPage extends StatefulWidget {
  const BarbershopRegisterPage({super.key});

  @override
  State<BarbershopRegisterPage> createState() => _BarbershopRegisterPageState();
}

class _BarbershopRegisterPageState extends State<BarbershopRegisterPage> {
  final formKey = GlobalKey<FormState>();
  final nameEC = TextEditingController();
  final emailEC = TextEditingController();

  @override
  void dispose() {
    nameEC.dispose();
    emailEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar estabelecimento'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
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
              const BarbershopWeekdaysGrid(),
              const SizedBox(height: 24),
              const SizedBox(height: 178, child: Placeholder()),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(56),
                ),
                child: const Text('CADASTRAR ESTABELECIMENTO'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
