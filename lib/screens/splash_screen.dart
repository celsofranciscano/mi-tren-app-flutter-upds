import 'package:flutter/material.dart';
import 'welcome_screen.dart';  // Importa la nueva pantalla de bienvenida

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    // Retrasa 3 segundos antes de ir a la pantalla de bienvenida
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        // Transición suave con desvanecimiento (fade)
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => const WelcomeScreen(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            transitionDuration: const Duration(seconds: 1),  // Duración de la transición
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue, // Fondo celeste
      body: Center(
        child: Image.asset(
          'lib/assets/logotren.png', // Ruta del logo en tu proyecto
          width: 150,
          height: 150,
        ),
      ),
    );
  }
}
