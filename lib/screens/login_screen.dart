import 'package:flutter/material.dart';
import 'main_screen.dart'; // Importa la pantalla principal
import 'register_screen.dart'; // Importa la pantalla de registro

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue, // Fondo celeste para la barra
        elevation: 0, // Sin sombra
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Regresar a la pantalla anterior
          },
        ),
        title: const Text(
          'Iniciar Sesión',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true, // Centrar el título
      ),
      body: Container(
        color: Colors.lightBlue, // Fondo celeste
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Logo en la parte superior
                Image.asset(
                  'lib/assets/logotren.png', // Cambia a la ruta de tu logo
                  width: 150,
                  height: 150,
                ),
                const SizedBox(height: 30),

                // Campo de Texto para Correo Electrónico
                _buildTextField(Icons.email, 'Correo Electrónico'),
                const SizedBox(height: 20),

                // Campo de Texto para Contraseña
                _buildTextField(Icons.lock, 'Contraseña', obscureText: true),
                const SizedBox(height: 30),

                // Botón de Iniciar Sesión
                _buildButton(context, 'Iniciar Sesión', Colors.blueAccent, Colors.white, () {
                  // Lógica para iniciar sesión
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const MainScreen()),
                  );
                }),
                const SizedBox(height: 20),

                // Texto de "¿No tienes cuenta? Crear cuenta"
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      '¿No tienes cuenta?',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const RegisterScreen()),
                        );
                      },
                      child: const Text(
                        'Crear cuenta',
                        style: TextStyle(
                          color: Colors.white, // Color blueAccent
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget para Campo de Texto
  Widget _buildTextField(IconData icon, String hintText, {bool obscureText = false}) {
    return TextField(
      obscureText: obscureText,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.white70),
        prefixIcon: Icon(icon, color: Colors.white70),
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
        contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(color: Colors.blueAccent), // Borde blueAccent
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blueAccent), // Borde blueAccent
          borderRadius: BorderRadius.circular(30.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blueAccent), // Borde blueAccent al estar enfocado
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
    );
  }

  // Widget para Botón
  Widget _buildButton(BuildContext context, String text, Color bgColor, Color textColor, VoidCallback onPressed) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 14.0),
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
