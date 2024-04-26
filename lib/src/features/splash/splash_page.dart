import 'package:dw_barbershop/src/features/auth/login/login_page.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  double _scale = 10.0;
  double _animationOpacityLogo = 0.0;

  /// Essa escala vai aumentar o tamanho original da logo
  double get _logoAnimationWidth => 100 * _scale;
  double get _logoAnimationHeight => 120 * _scale;

  /// Ao iniciar a tela, o logo aparece com uma animação
  /// voltando para o tamanho original e a opacitade para 1
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _animationOpacityLogo = 1.0;
        _scale = 1.0;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background_image_chair.jpg'),
            fit: BoxFit.cover,
            opacity: .2,
          ),
        ),
        child: Center(
          child: AnimatedOpacity(
            duration: const Duration(seconds: 3),
            curve: Curves.easeIn,
            opacity: _animationOpacityLogo,
            onEnd: () {
              Navigator.of(context).pushAndRemoveUntil(
                  PageRouteBuilder(
                    settings: const RouteSettings(name: '/auth/login'),
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const LoginPage(),
                    transitionsBuilder: (_, animation, __, child) =>
                        FadeTransition(
                      opacity: animation,
                      child: child,
                    ),
                  ),
                  (route) => false);
            },
            child: AnimatedContainer(
              duration: const Duration(seconds: 3),
              curve: Curves.linearToEaseOut,
              width: _logoAnimationWidth,
              height: _logoAnimationHeight,
              child: Image.asset(
                'assets/images/imgLogo.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
