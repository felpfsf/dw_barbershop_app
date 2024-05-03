import 'package:dw_barbershop/src/core/ui/barbershop_theme.dart';
import 'package:dw_barbershop/src/core/ui/constants.dart';
import 'package:dw_barbershop/src/core/ui/helpers/helper_form.dart';
import 'package:dw_barbershop/src/core/ui/helpers/messages.dart';
import 'package:dw_barbershop/src/features/auth/login/login_state.dart';
import 'package:dw_barbershop/src/features/auth/login/login_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:validatorless/validatorless.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final emailEC = TextEditingController(text: 'felpfsf@adf.com.br');
  final passwordEC = TextEditingController(text: '123123');

  @override
  void dispose() {
    super.dispose();
    emailEC.dispose();
    passwordEC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final LoginVM(:login) = ref.watch(loginVMProvider.notifier);

    ref.listen(loginVMProvider, (_, state) {
      switch (state) {
        case LoginState(status: LoginStateStatus.initial):
          break;

        case LoginState(
            status: LoginStateStatus.error,
            error: final errorMessage?
          ):
          Messages.showError(errorMessage, context);
          break;

        case LoginState(status: LoginStateStatus.error):
          Messages.showError('Erro ao realizar login', context);
          break;

        case LoginState(status: LoginStateStatus.admLogin):
          // redirect user
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/home/adm', (route) => false);
          break;

        case LoginState(status: LoginStateStatus.employeeLogin):
          // redirect user
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/home/employee', (route) => false);
          break;
      }
    });

    void handleSubmit() {
      // Valida
      // final isValid = formKey.currentState?.validate() ?? false;
      // if (isValid) {
      //   login(emailEC.text, passwordEC.text);
      // }

      // Ou assim

      switch (formKey.currentState?.validate()) {
        case (false || null):
          // Error message
          Messages.showError('Email ou senha inválido', context);
          break;
        case (true):
          // Success
          login(emailEC.text, passwordEC.text);
          break;
      }
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Form(
        key: formKey,
        child: DecoratedBox(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Assets.bgChairImage),
              opacity: 0.2,
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(24.0),
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/imgLogo.png',
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(height: 48),
                          TextFormField(
                            controller: emailEC,
                            validator: Validatorless.multiple([
                              Validatorless.required('Email obrigatório'),
                              Validatorless.email('Email inválido'),
                            ]),
                            onTapOutside: (_) => context.unfocus(),
                            keyboardType: TextInputType.emailAddress,
                            style: const TextStyle(color: Colors.black),
                            decoration: const InputDecoration(
                              label: Text('E-mail'),
                              hintText: 'E-mail',
                            ),
                          ),
                          const SizedBox(height: 24),
                          TextFormField(
                            controller: passwordEC,
                            validator: Validatorless.multiple([
                              Validatorless.required('Senha obrigatória'),
                              Validatorless.min(6,
                                  'Senha deve conter pelo menos 6 caracteres'),
                            ]),
                            obscureText: true,
                            onTapOutside: (_) => context.unfocus(),
                            style: const TextStyle(color: Colors.black),
                            decoration: const InputDecoration(
                              label: Text('Senha'),
                              hintText: '************',
                            ),
                          ),
                          const SizedBox(height: 24),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Esqueceu sua senha?',
                              style: BarbershopTheme.smallMdBodyStyle,
                            ),
                          ),
                          const SizedBox(height: 24),
                          SizedBox(
                            width: double.infinity,
                            height: 48,
                            child: ElevatedButton(
                              onPressed: handleSubmit,
                              child: const Text('ACESSAR'),
                            ),
                          ),
                        ],
                      ),
                      const Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          'Criar conta',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
