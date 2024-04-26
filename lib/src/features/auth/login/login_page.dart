import 'package:dw_barbershop/src/core/ui/barbershop_theme.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background_image_chair.jpg'),
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
                          keyboardType: TextInputType.emailAddress,
                          style: const TextStyle(color: Colors.black),
                          decoration: const InputDecoration(
                            label: Text('E-mail'),
                            hintText: 'E-mail',
                          ),
                        ),
                        const SizedBox(height: 24),
                        TextFormField(
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
                            onPressed: () {},
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
    );
  }
}
