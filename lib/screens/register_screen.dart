import 'package:flutter/material.dart';
import 'login_screen.dart'; // Pantalla de inicio de sesión
import 'main_screen.dart'; // Importa la pantalla principal

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

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
          'Crear Cuenta',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true, // Centrar el título
      ),
      body: Container(
        color: Colors.lightBlue, // Fondo celeste sin gradiente
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

                // Campo de texto para el Nombre
                _buildTextField(Icons.person, 'Nombre'),
                const SizedBox(height: 15),

                // Campo de texto para el Apellido
                _buildTextField(Icons.person, 'Apellido'),
                const SizedBox(height: 15),

                // Campo de texto para el Email
                _buildTextField(Icons.email, 'Correo Electrónico'),
                const SizedBox(height: 15),

                // Campo de texto para la Contraseña
                _buildTextField(Icons.lock, 'Contraseña', obscureText: true),
                const SizedBox(height: 30),

                // Botón de "Registrarse"
                ElevatedButton(
                  onPressed: () {
                    // Lógica de registro
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const MainScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14.0),
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                  ),
                  child: const Text(
                    'Registrarse',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20),

                // Texto o enlace para iniciar sesión
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      '¿Ya tienes cuenta?',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginScreen()),
                        );
                      },
                      child: const Text(
                        'Inicia sesión',
                        style: TextStyle(
                          color: Colors.white,
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

  // Widget para crear el Campo de Texto
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
          borderSide: const BorderSide(color: Colors.blueAccent), // Borde blueAccent
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
    );
  }
}
