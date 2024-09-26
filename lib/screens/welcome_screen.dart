import 'package:flutter/material.dart';
import 'login_screen.dart';  // Importa la pantalla de inicio de sesión
import 'register_screen.dart'; // Importa la pantalla de registro
import 'main_screen.dart'; // Importa la pantalla principal

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Imagen de fondo
          SizedBox.expand(
            child: Image.asset(
              'lib/assets/fondotren.png', // Asegúrate de que esta imagen esté en tu proyecto
              fit: BoxFit.cover,
            ),
          ),
          // Capa de color celeste con Opacidad
          Container(
            color: Colors.lightBlue.withOpacity(0.6), // Fondo celeste semitransparente
          ),
          // Contenido principal
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo en la parte superior
              Padding(
                padding: const EdgeInsets.only(top: 100.0),
                child: Image.asset(
                  'lib/assets/logotren.png', // Ruta del logo
                  width: 150,
                  height: 150,
                ),
              ),
              const SizedBox(height: 50),
              // Botón de Iniciar Sesión
              Center( // Usamos Center para centrar horizontalmente
                child: _buildButton(context, 'Iniciar Sesión', Colors.blueAccent, Colors.white, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                  );
                }),
              ),
              const SizedBox(height: 20),
              // Botón de Registrarse
              Center( // Usamos Center para centrar horizontalmente
                child: _buildButton(context, 'Registrarse', Colors.white, Colors.blueAccent, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const RegisterScreen()),
                  );
                }),
              ),
              const SizedBox(height: 30),

              // Texto de "Ingresar sin cuenta"
              TextButton(
                onPressed: () {
                  // Navega a MainScreen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MainScreen()),
                  );
                },
                child: const Text(
                  'Ingresar sin cuenta',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Widget para los botones
  Widget _buildButton(BuildContext context, String text, Color bgColor, Color textColor, VoidCallback onPressed) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 80.0),
        backgroundColor: bgColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        elevation: 5,
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(color: textColor, fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
