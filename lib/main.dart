import 'package:flutter/material.dart';
import 'screens/splash_screen.dart'; // Importa la pantalla de splash

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplicación de Trenes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(), // Establece la pantalla de splash como la pantalla inicial
    );
  }
}
